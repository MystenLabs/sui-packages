module 0x9f53b02a6ed1abac702c84654338c8a172961096099b0915524965704865a29d::constants {
    public fun fee_percent_scalling() : u64 {
        1000000
    }

    public fun fee_scalling() : u128 {
        1000000
    }

    public fun lp_token_metadata() : (u8, vector<u8>, vector<u8>, vector<u8>) {
        (9, b"KDMM", b"Kriya DeepBook MM LP Token", b"Token to represent your share in Kriya Deepbook MM")
    }

    public fun minimal_liquidity() : u64 {
        1000
    }

    public fun strategy_active() : 0x1::string::String {
        0x1::string::utf8(b"strategy_active")
    }

    public fun strategy_paused_and_ready_for_deposit_processing() : 0x1::string::String {
        0x1::string::utf8(b"strategy_paused_and_ready_for_deposit_processing")
    }

    public fun strategy_paused_and_ready_for_withdrawal_processing() : 0x1::string::String {
        0x1::string::utf8(b"strategy_paused_and_ready_for_withdrawal_processing")
    }

    public fun strategy_paused_and_ready_to_start() : 0x1::string::String {
        0x1::string::utf8(b"strategy_paused_and_ready_to_start")
    }

    public fun withdraw_fee_percent() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

