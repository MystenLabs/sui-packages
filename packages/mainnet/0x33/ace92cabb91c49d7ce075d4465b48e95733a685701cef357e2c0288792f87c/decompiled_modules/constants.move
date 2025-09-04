module 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

