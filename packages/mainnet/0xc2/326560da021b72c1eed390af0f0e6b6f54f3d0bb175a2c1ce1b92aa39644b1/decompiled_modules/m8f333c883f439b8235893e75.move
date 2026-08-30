module 0xc2326560da021b72c1eed390af0f0e6b6f54f3d0bb175a2c1ce1b92aa39644b1::m8f333c883f439b8235893e75 {
    public fun f0485de5ab92bee95ae4cf3c6<T0: drop>(arg0: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::redeem<T0>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

