module 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

