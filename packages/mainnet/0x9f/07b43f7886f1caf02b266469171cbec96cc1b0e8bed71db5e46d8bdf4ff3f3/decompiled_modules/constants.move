module 0x9f07b43f7886f1caf02b266469171cbec96cc1b0e8bed71db5e46d8bdf4ff3f3::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

