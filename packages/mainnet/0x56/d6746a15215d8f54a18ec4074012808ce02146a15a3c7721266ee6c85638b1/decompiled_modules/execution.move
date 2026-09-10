module 0x56d6746a15215d8f54a18ec4074012808ce02146a15a3c7721266ee6c85638b1::execution {
    public fun maybe_mint<T0: drop>(arg0: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        0x1::option::some<0x2::coin::Coin<T0>>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T0>(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(arg2), arg3))
    }

    public fun maybe_redeem<T0: drop>(arg0: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg1)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg1);
            return 0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T0>(arg0, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg1), arg2, arg3))
    }

    // decompiled from Move bytecode v7
}

