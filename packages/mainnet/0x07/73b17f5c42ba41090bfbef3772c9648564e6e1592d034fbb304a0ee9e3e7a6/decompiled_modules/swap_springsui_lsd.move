module 0x773b17f5c42ba41090bfbef3772c9648564e6e1592d034fbb304a0ee9e3e7a6::swap_springsui_lsd {
    public fun swap_a2b<T0: drop, T1, T2>(arg0: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T1, T2>, arg4: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T0>(arg0, arg1, arg2, arg5);
        let v1 = 0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg0);
        0x773b17f5c42ba41090bfbef3772c9648564e6e1592d034fbb304a0ee9e3e7a6::swap_event::emit_common_swap<0x2::sui::SUI, T0>(0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::consts::LSD_SPRINGSUI(), 0x2::object::id_to_address(&v1), true, 0x2::coin::value<0x2::sui::SUI>(&arg2), 0x2::coin::value<T0>(&v0), true);
        v0
    }

    public fun swap_b2a<T0: drop, T1, T2>(arg0: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<T0>, arg3: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T1, T2>, arg4: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T0>(arg0, arg2, arg1, arg5);
        let v1 = 0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg0);
        0x773b17f5c42ba41090bfbef3772c9648564e6e1592d034fbb304a0ee9e3e7a6::swap_event::emit_common_swap<0x2::sui::SUI, T0>(0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::consts::LSD_SPRINGSUI(), 0x2::object::id_to_address(&v1), false, 0x2::coin::value<T0>(&arg2), 0x2::coin::value<0x2::sui::SUI>(&v0), true);
        v0
    }

    // decompiled from Move bytecode v6
}

