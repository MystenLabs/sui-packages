module 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

