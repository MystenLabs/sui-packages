module 0x22593b7c18b3204c6afa992e47bd9607accc36e6f84e5261540324e4beda9931::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

