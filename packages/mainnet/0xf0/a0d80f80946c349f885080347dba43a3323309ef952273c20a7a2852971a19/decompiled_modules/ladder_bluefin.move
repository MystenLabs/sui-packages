module 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder_bluefin {
    public fun collect_reward<T0, T1, T2>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T1>(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 0);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::pay_reward<T0, T1, T2>(arg0, arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg4, arg1, arg2, 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::borrow_any_mut<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, arg3)), arg5);
    }

    public fun add<T0, T1>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Ticket, arg1: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T1>(arg1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 0);
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v1), 730);
        let v2 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::tick_spacing<T0, T1>(arg1);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::is_valid_index(v0, v2) && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::is_valid_index(v1, v2), 730);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::check_bid<T0, T1>(arg0, arg1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(v0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(v1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3), v1), arg6);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg2, arg3, arg4, arg5, arg8);
        let (v4, v5, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg7, arg2, arg3, &mut v3, 0x2::balance::zero<T0>(), 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::take_idle_q<T0, T1>(arg1), arg6, false);
        0x2::balance::destroy_zero<T0>(v6);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::record_bid<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, arg1, v3, arg4, arg5, v4, v5, v7);
    }

    fun amounts<T0, T1>(arg0: &0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg1: u128) : (u64, u64) {
        let (v0, v1) = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::idle<T0, T1>(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::ranges<T0, T1>(arg0);
        if (0x1::vector::is_empty<0x2::object::ID>(&v4)) {
            return (v0, v1)
        };
        0x1::vector::reverse<0x2::object::ID>(&mut v4);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(&v4)) {
            let v6 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::borrow_range<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, 0x1::vector::pop_back<0x2::object::ID>(&mut v4));
            let (v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_amount_by_liquidity(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(v6), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(v6), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_tick_at_sqrt_price(arg1), arg1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v6), false);
            v3 = v3 + v7;
            v2 = v2 + v8;
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v4);
        (v3, v2)
    }

    public fun begin<T0, T1, T2>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T2>, arg1: &0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg3: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Ticket {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T2>(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg4), 0);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::start_ticket<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg4), v0, arg6);
        let (v2, v3) = amounts<T0, T2>(arg0, v1);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::make_ticket<T0, T2>(arg0, v1, v2, v3, v0)
    }

    public fun close_retired<T0, T1>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T1>(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 0);
        let v0 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::pop_retired<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, arg3);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::is_empty(&v0), 731);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg4, arg1, arg2, v0);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::emit_closed<T0, T1>(arg0, arg3);
    }

    entry fun observe<T0, T1>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg1: &0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_version(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_keeper(arg2, arg5);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T1>(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 0);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::record_price<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3));
    }

    public fun open<T0, T1, T2>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Registry, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::bundle::Bundle<T0, T2>, arg3: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::new_for_bundle<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T2>(arg4), 0x2::clock::timestamp_ms(arg6), arg7);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T2>(&v0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg4), 0);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::share<T0, T2>(v0);
    }

    public fun remove<T0, T1>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Ticket, arg1: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::object::ID, arg5: u128, arg6: &0x2::clock::Clock) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_ticket<T0, T1>(arg0, arg1);
        take_range<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun take_range<T0, T1>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: u128, arg5: &0x2::clock::Clock) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T1>(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 0);
        let v0 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::borrow_range_mut<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, arg3);
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg5, arg1, arg2, v0);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v0);
        let v6 = if (arg4 > v5) {
            v5
        } else {
            arg4
        };
        let (v7, v8) = if (v6 > 0) {
            let (v9, v10, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg1, arg2, v0, v6, arg5);
            let _ = v10;
            let _ = v9;
            (v11, v12)
        } else {
            let _ = 0;
            let _ = 0;
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v15 = v6 == v5;
        let v16 = false;
        if (v15) {
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::is_empty(v0)) {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg5, arg1, arg2, 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::pop_range<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, arg3));
            } else {
                0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::retire<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::pop_range<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, arg3));
                v16 = true;
            };
        };
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::keep_removed<T0, T1>(arg0, arg3, v6, v7, v8, v3, v4, v15, v16);
    }

    public fun unwind<T0, T1, T2>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_can_unwind<T0, T1, T2>(arg0, arg1, 0x2::clock::timestamp_ms(arg5));
        take_range<T0, T2>(arg0, arg2, arg3, arg4, 340282366920938463463374607431768211455, arg5);
    }

    // decompiled from Move bytecode v7
}

