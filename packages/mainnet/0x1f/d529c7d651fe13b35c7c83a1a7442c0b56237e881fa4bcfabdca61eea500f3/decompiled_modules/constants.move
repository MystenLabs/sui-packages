module 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

