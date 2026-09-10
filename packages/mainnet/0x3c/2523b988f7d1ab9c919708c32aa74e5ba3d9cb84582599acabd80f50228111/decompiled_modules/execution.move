module 0x3c2523b988f7d1ab9c919708c32aa74e5ba3d9cb84582599acabd80f50228111::execution {
    public fun maybe_mint<T0: drop>(arg0: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        0x1::option::some<0x2::coin::Coin<T0>>(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::mint<T0>(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(arg2), arg3))
    }

    public fun maybe_redeem<T0: drop>(arg0: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg1)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg1);
            return 0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::redeem<T0>(arg0, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg1), arg2, arg3))
    }

    // decompiled from Move bytecode v7
}

