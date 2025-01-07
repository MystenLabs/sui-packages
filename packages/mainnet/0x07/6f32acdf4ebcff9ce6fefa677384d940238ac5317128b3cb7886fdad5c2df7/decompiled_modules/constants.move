module 0x76f32acdf4ebcff9ce6fefa677384d940238ac5317128b3cb7886fdad5c2df7::constants {
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

    public fun withdraw_fee_percent() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

