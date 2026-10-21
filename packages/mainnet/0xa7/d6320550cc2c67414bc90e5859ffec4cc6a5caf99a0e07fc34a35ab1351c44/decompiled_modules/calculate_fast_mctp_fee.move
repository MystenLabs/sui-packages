module 0xa7d6320550cc2c67414bc90e5859ffec4cc6a5caf99a0e07fc34a35ab1351c44::calculate_fast_mctp_fee {
    public fun calculate_protocol_fee_rate(arg0: &0xa7d6320550cc2c67414bc90e5859ffec4cc6a5caf99a0e07fc34a35ab1351c44::state::FeeManagerState, arg1: u8, arg2: u32, arg3: address, arg4: u64, arg5: address, arg6: address, arg7: u8) : u8 {
        0xa7d6320550cc2c67414bc90e5859ffec4cc6a5caf99a0e07fc34a35ab1351c44::state::assert_valid_version(arg0);
        3
    }

    // decompiled from Move bytecode v7
}

