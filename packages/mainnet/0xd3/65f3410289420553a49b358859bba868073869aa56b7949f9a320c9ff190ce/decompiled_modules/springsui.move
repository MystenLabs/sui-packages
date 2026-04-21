module 0xd365f3410289420553a49b358859bba868073869aa56b7949f9a320c9ff190ce::springsui {
    public fun stake<T0: drop>(arg0: &0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::HopReceipt, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg3: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::weight::WeightHook<T0>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::weight::rebalance<T0>(arg3, arg4, arg2, arg5);
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T0>(arg2, arg4, arg1, arg5)
    }

    public fun unstake<T0: drop>(arg0: &0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::HopReceipt, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T0>(arg2, arg1, arg3, arg4)
    }

    // decompiled from Move bytecode v7
}

