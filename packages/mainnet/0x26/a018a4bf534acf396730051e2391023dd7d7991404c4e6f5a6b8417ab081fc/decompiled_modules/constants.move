module 0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::constants {
    public fun fee_percent_scalling() : u64 {
        1000000
    }

    public fun fee_scalling() : u128 {
        1000000
    }

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

    public fun strategy_paused_and_ready_for_deposit_processing() : u8 {
        1
    }

    public fun strategy_paused_and_ready_for_withdrawal_processing() : u8 {
        2
    }

    public fun withdraw_fee_percent() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

