module 0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

