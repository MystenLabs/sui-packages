module 0x5000d64ee2a34a49ecca43e21527839b04085f5adce047ff2e3ec75e7cfce210::calculate_fast_mctp_fee {
    public fun calculate_protocol_fee_rate(arg0: &0x5000d64ee2a34a49ecca43e21527839b04085f5adce047ff2e3ec75e7cfce210::state::FeeManagerState, arg1: u8, arg2: u32, arg3: address, arg4: u64, arg5: address, arg6: address, arg7: u8) : u8 {
        0x5000d64ee2a34a49ecca43e21527839b04085f5adce047ff2e3ec75e7cfce210::state::assert_valid_version(arg0);
        3
    }

    // decompiled from Move bytecode v7
}

