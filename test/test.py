# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):

    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 2)
    dut.rst_n.value = 1

    # Matching pattern test
    dut.ui_in.value = 0b10101010
    await ClockCycles(dut.clk, 1)

    assert int(dut.uo_out.value) & 1 == 1

    # Non-matching pattern test
    dut.ui_in.value = 0b11110000
    await ClockCycles(dut.clk, 1)

    assert int(dut.uo_out.value) & 1 == 0
