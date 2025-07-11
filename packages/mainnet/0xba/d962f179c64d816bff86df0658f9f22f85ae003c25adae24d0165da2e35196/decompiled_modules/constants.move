module 0xbad962f179c64d816bff86df0658f9f22f85ae003c25adae24d0165da2e35196::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

