# Copyright(c) 2015-2019 ACCESS CO., LTD. All rights reserved.

use Croma
alias Croma.Result, as: R

defmodule AntikytheraEal.ClusterConfiguration do
  defmodule Behaviour do
    @moduledoc """
    Interface for cluster membership.

    See `AntikytheraEal` for common information about pluggable interfaces defined in antikythera.
    """

    @doc """
    Lists running ErlangVM nodes for the current deployment.

    On success this callback must return a map where
    each key is hostname (`String.t`) of a running node and
    each value is a boolean value representing whether the node is "active" or not.
    "Inactive" node is treated as during decommission process.

    This callback is at the startup of each node in order to join the existing cluster.
    After successful startup, this callback is called periodically so that

    - all running nodes in the cluster maintain connections to each other, and
    - each node can notice and cleanup when it is about to be terminated.
    """
    @callback running_hosts() :: R.t(%{String.t => boolean})

    @doc """
    Returns identifier of the data center zone in which current node is running.

    This callback is called only at startup and the return value is passed to `RaftFleet.activate/1`.
    """
    @callback zone_of_this_host() :: String.t
  end

  defmodule StandAlone do
    @behaviour Behaviour

    @impl true
    defun running_hosts() :: R.t(%{String.t => boolean}) do
      [_, host] = Node.self() |> Atom.to_string() |> String.split("@")
      {:ok, %{host => true}}
    end

    @impl true
    defun zone_of_this_host() :: String.t, do: "zone"
  end

  use AntikytheraEal.ImplChooser
end
