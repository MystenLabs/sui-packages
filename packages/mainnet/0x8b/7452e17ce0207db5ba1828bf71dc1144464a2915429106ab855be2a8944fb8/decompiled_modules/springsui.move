module 0x8b7452e17ce0207db5ba1828bf71dc1144464a2915429106ab855be2a8944fb8::springsui {
    public fun swap<T0: drop>(arg0: &mut 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::SwapContext, arg1: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a2b<T0>(arg0, arg1, arg2, arg3, arg5);
        } else {
            swap_b2a<T0>(arg0, arg1, arg2, arg3, arg5);
        };
    }

    public fun swap_a2b<T0: drop>(arg0: &mut 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::SwapContext, arg1: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::take_balance<0x2::sui::SUI>(arg0, arg3);
        let v1 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T0>(arg1, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4), arg4);
        0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::emit_swap_event<0x2::sui::SUI, T0>(arg0, b"SPRINGSUI", 0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg1), 0x2::balance::value<0x2::sui::SUI>(&v0), 0x2::coin::value<T0>(&v1), 0, true);
    }

    public fun swap_b2a<T0: drop>(arg0: &mut 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::SwapContext, arg1: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::take_balance<T0>(arg0, arg3);
        let v1 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T0>(arg1, 0x2::coin::from_balance<T0>(v0, arg4), arg2, arg4);
        0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v1));
        0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::emit_swap_event<T0, 0x2::sui::SUI>(arg0, b"SPRINGSUI", 0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg1), 0x2::balance::value<T0>(&v0), 0x2::coin::value<0x2::sui::SUI>(&v1), 0, false);
    }

    // decompiled from Move bytecode v6
}

