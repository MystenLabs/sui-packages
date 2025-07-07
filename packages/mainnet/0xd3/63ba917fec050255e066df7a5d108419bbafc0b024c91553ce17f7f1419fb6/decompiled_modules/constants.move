module 0xd363ba917fec050255e066df7a5d108419bbafc0b024c91553ce17f7f1419fb6::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

