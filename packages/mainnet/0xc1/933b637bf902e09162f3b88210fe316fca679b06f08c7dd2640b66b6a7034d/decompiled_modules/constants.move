module 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

