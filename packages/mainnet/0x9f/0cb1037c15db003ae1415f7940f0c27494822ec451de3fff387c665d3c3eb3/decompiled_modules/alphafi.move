module 0x9f0cb1037c15db003ae1415f7940f0c27494822ec451de3fff387c665d3c3eb3::alphafi {
    public fun swap<T0: drop>(arg0: &mut 0x13a6c63ecf3104331865348bd6b81adae2841358dbe76bf8df331640a790e37f::router::SwapContext, arg1: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0>(arg0, arg1, arg2, arg4, arg5);
        } else {
            swap_b2a<T0>(arg0, arg1, arg2, arg4, arg5);
        };
    }

    fun swap_a2b<T0: drop>(arg0: &mut 0x13a6c63ecf3104331865348bd6b81adae2841358dbe76bf8df331640a790e37f::router::SwapContext, arg1: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x13a6c63ecf3104331865348bd6b81adae2841358dbe76bf8df331640a790e37f::router::take_balance<0x2::sui::SUI>(arg0, arg3);
        let v1 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::mint<T0>(arg1, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4), arg4);
        0x13a6c63ecf3104331865348bd6b81adae2841358dbe76bf8df331640a790e37f::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        0x13a6c63ecf3104331865348bd6b81adae2841358dbe76bf8df331640a790e37f::router::emit_swap_event<0x2::sui::SUI, T0>(arg0, b"ALPHAFI", 0x2::object::id<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>>(arg1), 0x2::balance::value<0x2::sui::SUI>(&v0), 0x2::coin::value<T0>(&v1), true);
    }

    fun swap_b2a<T0: drop>(arg0: &mut 0x13a6c63ecf3104331865348bd6b81adae2841358dbe76bf8df331640a790e37f::router::SwapContext, arg1: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x13a6c63ecf3104331865348bd6b81adae2841358dbe76bf8df331640a790e37f::router::take_balance<T0>(arg0, arg3);
        let v1 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::redeem<T0>(arg1, 0x2::coin::from_balance<T0>(v0, arg4), arg2, arg4);
        0x13a6c63ecf3104331865348bd6b81adae2841358dbe76bf8df331640a790e37f::router::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v1));
        0x13a6c63ecf3104331865348bd6b81adae2841358dbe76bf8df331640a790e37f::router::emit_swap_event<T0, 0x2::sui::SUI>(arg0, b"ALPHAFI", 0x2::object::id<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>>(arg1), 0x2::balance::value<T0>(&v0), 0x2::coin::value<0x2::sui::SUI>(&v1), false);
    }

    // decompiled from Move bytecode v6
}

