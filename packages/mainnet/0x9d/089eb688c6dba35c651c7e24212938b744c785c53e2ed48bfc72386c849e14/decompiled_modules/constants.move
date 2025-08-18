module 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::constants {
    public fun deposit_enabled_df_key() : vector<u8> {
        b"deposit_enabled"
    }

    public fun max_vc_amount_per_seed() : u64 {
        100000000
    }

    // decompiled from Move bytecode v6
}

