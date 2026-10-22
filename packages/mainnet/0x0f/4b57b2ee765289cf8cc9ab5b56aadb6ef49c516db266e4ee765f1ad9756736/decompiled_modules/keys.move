module 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys {
    struct LendingStateKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ShareMetadataKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RewardsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LiquidityCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun lending_state_key<T0>() : LendingStateKey<T0> {
        LendingStateKey<T0>{dummy_field: false}
    }

    public(friend) fun liquidity_cap_key() : LiquidityCapKey {
        LiquidityCapKey{dummy_field: false}
    }

    public(friend) fun rewards_key() : RewardsKey {
        RewardsKey{dummy_field: false}
    }

    public(friend) fun share_metadata_key() : ShareMetadataKey {
        ShareMetadataKey{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

