module 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

