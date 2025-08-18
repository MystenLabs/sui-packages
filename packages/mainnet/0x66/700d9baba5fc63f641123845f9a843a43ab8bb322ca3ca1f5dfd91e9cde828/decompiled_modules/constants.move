module 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

