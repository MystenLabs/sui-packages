module 0x5c2b348f17d648f842ff6338d903ce7d72a5c2256859583b783fe81b32cf273a::mc5eec45fa3637a9f51519d33 {
    public fun f58c4f117cb797600a5e0a3b3<T0: drop>(arg0: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::redeem<T0>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

