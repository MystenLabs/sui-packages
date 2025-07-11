module 0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

