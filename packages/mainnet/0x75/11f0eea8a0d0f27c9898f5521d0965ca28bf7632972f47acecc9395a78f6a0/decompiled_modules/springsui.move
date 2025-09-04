module 0x7511f0eea8a0d0f27c9898f5521d0965ca28bf7632972f47acecc9395a78f6a0::springsui {
    public fun swap<T0: drop>(arg0: &mut 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext, arg1: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a2b<T0>(arg0, arg1, arg2, arg3, arg5);
        } else {
            swap_b2a<T0>(arg0, arg1, arg2, arg3, arg5);
        };
    }

    public fun swap_a2b<T0: drop>(arg0: &mut 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext, arg1: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::take_balance<0x2::sui::SUI>(arg0, arg3);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        let v2 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T0>(arg1, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4), arg4);
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::emit_swap_event<0x2::sui::SUI, T0>(arg0, b"SPRINGSUI", 0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg1), v1, 0x2::coin::value<T0>(&v2), 0);
    }

    public fun swap_b2a<T0: drop>(arg0: &mut 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext, arg1: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T0>(arg1, 0x2::coin::from_balance<T0>(v0, arg4), arg2, arg4);
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::emit_swap_event<T0, 0x2::sui::SUI>(arg0, b"SPRINGSUI", 0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg1), v1, 0x2::coin::value<0x2::sui::SUI>(&v2), 0);
    }

    // decompiled from Move bytecode v6
}

