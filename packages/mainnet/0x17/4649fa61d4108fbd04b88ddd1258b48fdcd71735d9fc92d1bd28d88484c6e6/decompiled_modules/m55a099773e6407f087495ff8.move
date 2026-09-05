module 0x174649fa61d4108fbd04b88ddd1258b48fdcd71735d9fc92d1bd28d88484c6e6::m55a099773e6407f087495ff8 {
    public fun ffe5bc255d3c23b87506fb5e9<T0: drop>(arg0: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::redeem<T0>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

