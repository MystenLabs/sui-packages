module 0x4f5e385cfd23bba90b05e9223becc8a59440f00f58f585c062cd0cfc8ea5b4aa::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

