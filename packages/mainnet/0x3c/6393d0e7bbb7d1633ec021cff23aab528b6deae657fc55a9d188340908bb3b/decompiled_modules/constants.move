module 0x3c6393d0e7bbb7d1633ec021cff23aab528b6deae657fc55a9d188340908bb3b::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

