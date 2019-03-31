# Copyright(c) 2015-2019 ACCESS CO., LTD. All rights reserved.

defmodule Antikythera.TimestampTest do
  use ExUnit.Case
  alias Antikythera.IsoTimestamp
  alias Antikythera.IsoTimestamp.Basic, as: IsoBasic

  test "validate IsoTimestamp" do
    [
      "1970-01-01T00:00:00.000+00:00",
      "9999-12-12T23:59:59.999+00:00",

      "1970-01-01T00:00:00.000+14:00",
      "1970-01-01T00:00:00.000-11:00",

      "1970-01-01T00:00:00.000Z",

      "1970-01-01T00:00:00+00:00",

      "1970-01-01T00:00:00.000+00:00",
      "1970-02-01T00:00:00.000+00:00",
      "1970-03-01T00:00:00.000+00:00",
      "1970-04-01T00:00:00.000+00:00",
      "1970-05-01T00:00:00.000+00:00",
      "1970-06-01T00:00:00.000+00:00",
      "1970-07-01T00:00:00.000+00:00",
      "1970-08-01T00:00:00.000+00:00",
      "1970-09-01T00:00:00.000+00:00",
      "1970-10-01T00:00:00.000+00:00",
      "1970-11-01T00:00:00.000+00:00",
      "1970-12-01T00:00:00.000+00:00",

      "1970-01-31T23:59:59.999+00:00",
      "1970-02-28T23:59:59.999+00:00",
      "1970-03-31T23:59:59.999+00:00",
      "1970-04-30T23:59:59.999+00:00",
      "1970-05-31T23:59:59.999+00:00",
      "1970-06-30T23:59:59.999+00:00",
      "1970-07-31T23:59:59.999+00:00",
      "1970-08-31T23:59:59.999+00:00",
      "1970-09-30T23:59:59.999+00:00",
      "1970-10-31T23:59:59.999+00:00",
      "1970-11-30T23:59:59.999+00:00",
      "1970-12-31T23:59:59.999+00:00",

      "1972-02-29T23:59:59.999+00:00",
      "2000-02-29T23:59:59.999+00:00",
      "2100-02-28T23:59:59.999+00:00",
    ] |> Enum.each(fn timestamp ->
      assert IsoTimestamp.valid?(timestamp)
    end)

    [
      "1970-01-01T00:00:00.000",
      "1970-01-01T00:00:00.000+00:00Z",

      "1970-01-00T23:59:59.999+00:00",
      "1970-02-00T23:59:59.999+00:00",
      "1970-03-00T23:59:59.999+00:00",
      "1970-04-00T23:59:59.999+00:00",
      "1970-05-00T23:59:59.999+00:00",
      "1970-06-00T23:59:59.999+00:00",
      "1970-07-00T23:59:59.999+00:00",
      "1970-08-00T23:59:59.999+00:00",
      "1970-09-00T23:59:59.999+00:00",
      "1970-10-00T23:59:59.999+00:00",
      "1970-11-00T23:59:59.999+00:00",
      "1970-12-00T23:59:59.999+00:00",

      "1970-01-32T00:00:00.000+00:00",
      "1970-02-29T00:00:00.000+00:00",
      "1970-03-32T00:00:00.000+00:00",
      "1970-04-31T00:00:00.000+00:00",
      "1970-05-32T00:00:00.000+00:00",
      "1970-06-31T00:00:00.000+00:00",
      "1970-07-32T00:00:00.000+00:00",
      "1970-08-32T00:00:00.000+00:00",
      "1970-09-31T00:00:00.000+00:00",
      "1970-10-32T00:00:00.000+00:00",
      "1970-11-31T00:00:00.000+00:00",
      "1970-12-32T00:00:00.000+00:00",

      "1972-02-30T00:00:00.000+00:00",
      "2000-02-30T00:00:00.000+00:00",
      "2100-02-29T00:00:00.000+00:00",
    ] |> Enum.each(fn incorrect ->
      refute IsoTimestamp.valid?(incorrect)
    end)

    [
      {"tuple"},
      :atom,
      0,
      0.0,
      %{},
      [],
    ] |> Enum.each(fn v ->
      refute IsoTimestamp.valid?(v)
    end)
  end

  test "validate IsoTimestamp.Basic" do
    [
      "19700101T000000+0000",
      "99991212T235959+0000",

      "19700101T000000+1400",
      "19700101T000000-1100",

      "19700101T000000Z",

      "19700101T000000+0000",
      "19700201T000000+0000",
      "19700301T000000+0000",
      "19700401T000000+0000",
      "19700501T000000+0000",
      "19700601T000000+0000",
      "19700701T000000+0000",
      "19700801T000000+0000",
      "19700901T000000+0000",
      "19701001T000000+0000",
      "19701101T000000+0000",
      "19701201T000000+0000",

      "19700131T235959+0000",
      "19700228T235959+0000",
      "19700331T235959+0000",
      "19700430T235959+0000",
      "19700531T235959+0000",
      "19700630T235959+0000",
      "19700731T235959+0000",
      "19700831T235959+0000",
      "19700930T235959+0000",
      "19701031T235959+0000",
      "19701130T235959+0000",
      "19701231T235959+0000",

      "19720229T235959+0000",
      "20000229T235959+0000",
      "21000228T235959+0000",
    ] |> Enum.each(fn timestamp ->
      assert IsoBasic.valid?(timestamp)
    end)

    [
      "19700101T000000",
      "19700101T000000+0000Z",

      "19700100T235959+0000",
      "19700200T235959+0000",
      "19700300T235959+0000",
      "19700400T235959+0000",
      "19700500T235959+0000",
      "19700600T235959+0000",
      "19700700T235959+0000",
      "19700800T235959+0000",
      "19700900T235959+0000",
      "19701000T235959+0000",
      "19701100T235959+0000",
      "19701200T235959+0000",

      "19700132T000000+0000",
      "19700229T000000+0000",
      "19700332T000000+0000",
      "19700431T000000+0000",
      "19700532T000000+0000",
      "19700631T000000+0000",
      "19700732T000000+0000",
      "19700832T000000+0000",
      "19700931T000000+0000",
      "19701032T000000+0000",
      "19701131T000000+0000",
      "19701232T000000+0000",

      "19720230T000000+0000",
      "20000230T000000+0000",
      "21000229T000000+0000",
    ] |> Enum.each(fn incorrect ->
      refute IsoBasic.valid?(incorrect)
    end)

    [
      {"tuple"},
      :atom,
      0,
      0.0,
      %{},
      [],
    ] |> Enum.each(fn v ->
      refute IsoBasic.valid?(v)
    end)
  end
end
