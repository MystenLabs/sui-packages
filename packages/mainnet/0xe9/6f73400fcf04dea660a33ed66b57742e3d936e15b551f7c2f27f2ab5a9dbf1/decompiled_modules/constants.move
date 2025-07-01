module 0xe96f73400fcf04dea660a33ed66b57742e3d936e15b551f7c2f27f2ab5a9dbf1::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

