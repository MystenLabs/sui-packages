module 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

