module 0xcc3077222cba99e18fcd9ccc3412591508f50eff0092822a8df5f12803a1dec2::calculate_fast_mctp_fee {
    public fun calculate_protocol_fee_rate(arg0: &0xcc3077222cba99e18fcd9ccc3412591508f50eff0092822a8df5f12803a1dec2::state::FeeManagerState, arg1: u8, arg2: u32, arg3: address, arg4: u64, arg5: address, arg6: address, arg7: u8) : u8 {
        0xcc3077222cba99e18fcd9ccc3412591508f50eff0092822a8df5f12803a1dec2::state::assert_valid_version(arg0);
        3
    }

    // decompiled from Move bytecode v7
}

