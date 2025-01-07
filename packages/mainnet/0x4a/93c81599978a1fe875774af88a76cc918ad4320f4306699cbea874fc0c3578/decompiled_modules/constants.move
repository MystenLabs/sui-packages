module 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

