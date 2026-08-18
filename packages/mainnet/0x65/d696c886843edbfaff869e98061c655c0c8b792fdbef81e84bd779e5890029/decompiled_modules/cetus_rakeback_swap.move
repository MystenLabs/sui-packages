module 0x7fec0d0f98b1f87867ba9d0cc01ff7659d0a7a8d0f3baa17c36dfc9ff0afdc91::cetus_rakeback_swap {
    struct CetusRakebackOperator has copy, drop, store {
        dummy_field: bool,
    }

    struct RakebackSwapEvent<phantom T0, phantom T1> has copy, drop {
        swap_id: 0x2::object::ID,
        actor: address,
        pool_id: 0x2::object::ID,
        a_to_b: bool,
        by_amount_in: bool,
        source_amount: u64,
        cetus_pay_amount: u64,
        target_amount: u64,
        refunded_source_amount: u64,
    }

    public fun admin_operator_swap_rakeback_exact_input_a_to_b<T0, T1>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        operator_swap_rakeback_exact_input_a_to_b_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    public fun admin_operator_swap_rakeback_exact_input_b_to_a<T0, T1>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        operator_swap_rakeback_exact_input_b_to_a_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    fun emit_swap_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: bool, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = RakebackSwapEvent<T0, T1>{
            swap_id                : arg1,
            actor                  : arg2,
            pool_id                : arg0,
            a_to_b                 : arg3,
            by_amount_in           : arg4,
            source_amount          : arg5,
            cetus_pay_amount       : arg6,
            target_amount          : arg7,
            refunded_source_amount : arg8,
        };
        0x2::event::emit<RakebackSwapEvent<T0, T1>>(v0);
    }

    public fun manager_operator_swap_rakeback_exact_input_a_to_b<T0, T1>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<CetusRakebackOperator>(arg1, 0x2::tx_context::sender(arg6));
        operator_swap_rakeback_exact_input_a_to_b_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    public fun manager_operator_swap_rakeback_exact_input_b_to_a<T0, T1>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<CetusRakebackOperator>(arg1, 0x2::tx_context::sender(arg6));
        operator_swap_rakeback_exact_input_b_to_a_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    fun operator_swap_rakeback_exact_input_a_to_b_internal<T0, T1>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusRakebackOperator{dummy_field: false};
        let (v1, v2) = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::swap_rakeback::operator_start_swap_coin<T0, T1, CetusRakebackOperator>(arg0, v0, arg4, arg5);
        let v3 = v2;
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let v7 = v6;
        let v8 = v5;
        0x2::balance::destroy_zero<T0>(v4);
        let v9 = 0x2::balance::value<T1>(&v8);
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7);
        assert!(v10 == arg4, 13835339989820375041);
        assert!(v9 > 0, 13835621469092184067);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(v1), 0x2::balance::zero<T1>(), v7);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::swap_rakeback::operator_settle_swap_balance<T0, T1, CetusRakebackOperator>(arg0, v0, v3, v8);
        emit_swap_event<T0, T1>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::swap_rakeback::swap_id<T0, T1, CetusRakebackOperator>(&v3), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::swap_rakeback::actor<T0, T1, CetusRakebackOperator>(&v3), true, true, arg4, v10, v9, 0);
    }

    fun operator_swap_rakeback_exact_input_b_to_a_internal<T0, T1>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusRakebackOperator{dummy_field: false};
        let (v1, v2) = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::swap_rakeback::operator_start_swap_coin<T1, T0, CetusRakebackOperator>(arg0, v0, arg4, arg5);
        let v3 = v2;
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v7 = v6;
        let v8 = v4;
        0x2::balance::destroy_zero<T1>(v5);
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7);
        assert!(v10 == arg4, 13835340281878151169);
        assert!(v9 > 0, 13835621761149960195);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v1), v7);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::swap_rakeback::operator_settle_swap_balance<T1, T0, CetusRakebackOperator>(arg0, v0, v3, v8);
        emit_swap_event<T1, T0>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::swap_rakeback::swap_id<T1, T0, CetusRakebackOperator>(&v3), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::swap_rakeback::actor<T1, T0, CetusRakebackOperator>(&v3), false, true, arg4, v10, v9, 0);
    }

    // decompiled from Move bytecode v7
}

