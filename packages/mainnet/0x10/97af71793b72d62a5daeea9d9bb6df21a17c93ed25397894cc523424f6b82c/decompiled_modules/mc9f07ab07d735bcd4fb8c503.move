module 0x1097af71793b72d62a5daeea9d9bb6df21a17c93ed25397894cc523424f6b82c::mc9f07ab07d735bcd4fb8c503 {
    public fun f3e38d5c12cc832828b1fa63c<T0: drop>(arg0: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T0>(arg0, arg1, arg2, arg3)
    }

    public fun fcc96387a5a9c7bd0eaadd202<T0: drop>(arg0: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T0>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

