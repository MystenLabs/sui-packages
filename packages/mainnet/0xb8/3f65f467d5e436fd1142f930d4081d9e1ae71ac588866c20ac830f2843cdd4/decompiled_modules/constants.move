module 0xb83f65f467d5e436fd1142f930d4081d9e1ae71ac588866c20ac830f2843cdd4::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

