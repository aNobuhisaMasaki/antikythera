# Copyright(c) 2015-2019 ACCESS CO., LTD. All rights reserved.

use Croma
alias AntikytheraCore.Metrics.AggregateStrategy, as: Strategy

defmodule Strategy.RequestCount do
  @moduledoc """
  Aggregate strategy for request counts.
  This calculates the following values from HTTP status codes of responses within a time window:

  - total number of requests
  - number of requests that result in 4XX response (client error)
  - number of requests that result in 5XX response (server error)

  Note that, strictly speaking, numbers generated by this aggreagate strategy do not include invalid requests
  that are rejected by antikythera before arriving at gear's controller action,
  i.e. requests which do not match any of the defined routes, requests with malformed body, etc.
  """

  @behaviour Strategy.Behaviour
  alias Antikythera.Http.Status

  @typep data_t :: {pos_integer, non_neg_integer, non_neg_integer}

  @impl true
  defun init(status :: v[Status.Int.t]) :: data_t do
    case div(status, 100) do
      4 -> {1, 1, 0}
      5 -> {1, 0, 1}
      _ -> {1, 0, 0}
    end
  end

  @impl true
  defun merge({count_total, count_4xx, count_5xx} :: data_t, status :: v[Status.Int.t]) :: data_t do
    case div(status, 100) do
      4 -> {count_total + 1, count_4xx + 1, count_5xx    }
      5 -> {count_total + 1, count_4xx    , count_5xx + 1}
      _ -> {count_total + 1, count_4xx    , count_5xx    }
    end
  end

  @impl true
  defun results({count_total, count_4xx, count_5xx} :: data_t) :: Strategy.results_t do
    [
      total: count_total,
      "4XX": count_4xx,
      "5XX": count_5xx,
    ]
  end
end
