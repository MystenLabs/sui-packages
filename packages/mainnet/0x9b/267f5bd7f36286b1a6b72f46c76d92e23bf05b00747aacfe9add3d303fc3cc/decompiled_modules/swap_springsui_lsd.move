module 0x9b267f5bd7f36286b1a6b72f46c76d92e23bf05b00747aacfe9add3d303fc3cc::swap_springsui_lsd {
    public fun swap_a2b<T0: drop, T1, T2>(arg0: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x9b267f5bd7f36286b1a6b72f46c76d92e23bf05b00747aacfe9add3d303fc3cc::swap_transaction::SwapTransaction<T1, T2>, arg4: &0x9b267f5bd7f36286b1a6b72f46c76d92e23bf05b00747aacfe9add3d303fc3cc::state::State, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T0>(arg0, arg1, arg2, arg5);
        let v1 = 0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg0);
        0x9b267f5bd7f36286b1a6b72f46c76d92e23bf05b00747aacfe9add3d303fc3cc::swap_event::emit_common_swap<0x2::sui::SUI, T0>(0x9b267f5bd7f36286b1a6b72f46c76d92e23bf05b00747aacfe9add3d303fc3cc::consts::LSD_SPRINGSUI(), 0x2::object::id_to_address(&v1), true, 0x2::coin::value<0x2::sui::SUI>(&arg2), 0x2::coin::value<T0>(&v0), true);
        v0
    }

    public fun swap_b2a<T0: drop, T1, T2>(arg0: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<T0>, arg3: &0x9b267f5bd7f36286b1a6b72f46c76d92e23bf05b00747aacfe9add3d303fc3cc::swap_transaction::SwapTransaction<T1, T2>, arg4: &0x9b267f5bd7f36286b1a6b72f46c76d92e23bf05b00747aacfe9add3d303fc3cc::state::State, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T0>(arg0, arg2, arg1, arg5);
        let v1 = 0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg0);
        0x9b267f5bd7f36286b1a6b72f46c76d92e23bf05b00747aacfe9add3d303fc3cc::swap_event::emit_common_swap<0x2::sui::SUI, T0>(0x9b267f5bd7f36286b1a6b72f46c76d92e23bf05b00747aacfe9add3d303fc3cc::consts::LSD_SPRINGSUI(), 0x2::object::id_to_address(&v1), false, 0x2::coin::value<T0>(&arg2), 0x2::coin::value<0x2::sui::SUI>(&v0), true);
        v0
    }

    // decompiled from Move bytecode v6
}

