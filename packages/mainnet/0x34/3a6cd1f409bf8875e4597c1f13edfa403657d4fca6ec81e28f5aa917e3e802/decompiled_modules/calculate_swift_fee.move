module 0x343a6cd1f409bf8875e4597c1f13edfa403657d4fca6ec81e28f5aa917e3e802::calculate_swift_fee {
    struct SwiftInitParams has drop {
        fee_rate_mayan: u8,
    }

    public fun calculate_swift_fee(arg0: &0x343a6cd1f409bf8875e4597c1f13edfa403657d4fca6ec81e28f5aa917e3e802::state::FeeManagerState, arg1: &mut 0x2::tx_context::TxContext) : SwiftInitParams {
        0x343a6cd1f409bf8875e4597c1f13edfa403657d4fca6ec81e28f5aa917e3e802::state::assert_valid_version(arg0);
        SwiftInitParams{fee_rate_mayan: 6}
    }

    public fun unpack_swift_init_params(arg0: SwiftInitParams) : u8 {
        arg0.fee_rate_mayan
    }

    // decompiled from Move bytecode v6
}

