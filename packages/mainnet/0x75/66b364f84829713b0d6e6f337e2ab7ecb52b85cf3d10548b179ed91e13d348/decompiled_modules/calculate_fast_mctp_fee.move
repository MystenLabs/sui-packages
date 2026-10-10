module 0x7566b364f84829713b0d6e6f337e2ab7ecb52b85cf3d10548b179ed91e13d348::calculate_fast_mctp_fee {
    public fun calculate_protocol_fee_rate(arg0: &0x7566b364f84829713b0d6e6f337e2ab7ecb52b85cf3d10548b179ed91e13d348::state::FeeManagerState, arg1: u8, arg2: u32, arg3: address, arg4: u64, arg5: address, arg6: address, arg7: u8) : u8 {
        0x7566b364f84829713b0d6e6f337e2ab7ecb52b85cf3d10548b179ed91e13d348::state::assert_valid_version(arg0);
        3
    }

    // decompiled from Move bytecode v7
}

