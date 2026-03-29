module 0x8c12861611f795ca0c29ea22aa1d26c18c8c94d25b0fd7c620dfc5f0d3a5994b::scallop_bridge {
    public fun deposit_to_scallop<T0>(arg0: &mut 0x6e7b6a103ffa0e7d26b596b52b4bb10dcdc7cf7990c72397d8bd19cd6b3ed46b::market::Market, arg1: &0x6e7b6a103ffa0e7d26b596b52b4bb10dcdc7cf7990c72397d8bd19cd6b3ed46b::version::Version, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6e7b6a103ffa0e7d26b596b52b4bb10dcdc7cf7990c72397d8bd19cd6b3ed46b::reserve::MarketCoin<T0>> {
        0x6e7b6a103ffa0e7d26b596b52b4bb10dcdc7cf7990c72397d8bd19cd6b3ed46b::mint::mint<T0>(arg1, arg0, arg3, arg2, arg4)
    }

    public fun withdraw_from_scallop<T0>(arg0: &mut 0x6e7b6a103ffa0e7d26b596b52b4bb10dcdc7cf7990c72397d8bd19cd6b3ed46b::market::Market, arg1: &0x6e7b6a103ffa0e7d26b596b52b4bb10dcdc7cf7990c72397d8bd19cd6b3ed46b::version::Version, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x6e7b6a103ffa0e7d26b596b52b4bb10dcdc7cf7990c72397d8bd19cd6b3ed46b::reserve::MarketCoin<T0>>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x6e7b6a103ffa0e7d26b596b52b4bb10dcdc7cf7990c72397d8bd19cd6b3ed46b::redeem::redeem<T0>(arg1, arg0, arg3, arg2, arg4)
    }

    // decompiled from Move bytecode v6
}

