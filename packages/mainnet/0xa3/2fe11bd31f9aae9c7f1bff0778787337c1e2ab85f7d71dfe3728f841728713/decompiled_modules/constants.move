module 0xa32fe11bd31f9aae9c7f1bff0778787337c1e2ab85f7d71dfe3728f841728713::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

