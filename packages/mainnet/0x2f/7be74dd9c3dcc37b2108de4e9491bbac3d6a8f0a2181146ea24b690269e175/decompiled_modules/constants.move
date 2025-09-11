module 0x2f7be74dd9c3dcc37b2108de4e9491bbac3d6a8f0a2181146ea24b690269e175::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

