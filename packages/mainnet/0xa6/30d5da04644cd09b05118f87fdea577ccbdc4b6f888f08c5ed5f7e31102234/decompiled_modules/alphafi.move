module 0xa630d5da04644cd09b05118f87fdea577ccbdc4b6f888f08c5ed5f7e31102234::alphafi {
    public fun swap_a2b<T0: drop>(arg0: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v0 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::mint<T0>(arg0, arg1, arg2, arg3);
        0x2::coin::value<T0>(&v0);
        v0
    }

    public fun swap_b2a<T0: drop>(arg0: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::value<T0>(&arg2);
        let v0 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::redeem<T0>(arg0, arg2, arg1, arg3);
        0x2::coin::value<0x2::sui::SUI>(&v0);
        v0
    }

    // decompiled from Move bytecode v6
}

