module 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants {
    public fun base_uint() : u64 {
        1000000
    }

    public fun claim_funds_payload_type() : u8 {
        2
    }

    public fun claim_rewards_payload_type() : u8 {
        1
    }

    public fun deposit_type() : u8 {
        0
    }

    public fun ed25519_scheme() : u8 {
        1
    }

    public fun get_version() : u64 {
        2
    }

    public fun min_shares() : u64 {
        100000
    }

    public fun no_pnl_sharing_vault_type() : u8 {
        1
    }

    public fun pnl_sharing_vault_type() : u8 {
        2
    }

    public fun secp256k1_scheme() : u8 {
        0
    }

    public fun withdraw_type() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

