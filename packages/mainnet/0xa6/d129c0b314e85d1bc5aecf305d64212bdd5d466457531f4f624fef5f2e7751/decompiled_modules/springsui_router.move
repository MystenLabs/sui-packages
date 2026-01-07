module 0xa6d129c0b314e85d1bc5aecf305d64212bdd5d466457531f4f624fef5f2e7751::springsui_router {
    public fun swap<T0: drop>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a_to_b<T0>(arg0, arg1, arg2, arg3, arg5);
        } else {
            swap_b_to_a<T0>(arg0, arg1, arg2, arg3, arg5);
        };
    }

    public fun swap_a_to_b<T0: drop>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::take_balance<0x2::sui::SUI>(arg0, arg3);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        let v2 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T0>(arg1, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4), arg4);
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::emit_swap_event<0x2::sui::SUI, T0>(arg0, b"springsui", 0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg1), v1, 0x2::coin::value<T0>(&v2), 0);
    }

    public fun swap_b_to_a<T0: drop>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T0>(arg1, 0x2::coin::from_balance<T0>(v0, arg4), arg2, arg4);
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::emit_swap_event<T0, 0x2::sui::SUI>(arg0, b"springsui", 0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg1), v1, 0x2::coin::value<0x2::sui::SUI>(&v2), 0);
    }

    // decompiled from Move bytecode v6
}

