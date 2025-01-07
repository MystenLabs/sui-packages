module 0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::constants {
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

