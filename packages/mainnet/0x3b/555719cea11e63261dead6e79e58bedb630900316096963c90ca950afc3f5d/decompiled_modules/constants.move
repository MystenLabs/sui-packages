module 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::constants {
    public fun lp_token_metadata() : (u8, vector<u8>, vector<u8>, vector<u8>) {
        (9, b"KDMM", b"Kriya DeepBook MM LP Token", b"Token to represent your share in Kriya Deepbook MM")
    }

    public fun min_deposit_amount() : u64 {
        10000000
    }

    public fun minimal_liquidity() : u64 {
        1000
    }

    public fun request_from_object() : u8 {
        1
    }

    public fun request_from_user() : u8 {
        0
    }

    public fun strategy_active() : u8 {
        0
    }

    public fun strategy_paused_and_ready_for_withdrawal_processing() : u8 {
        2
    }

    public fun withdraw_fee_scaling_factor() : u64 {
        1000000
    }

    // decompiled from Move bytecode v6
}

