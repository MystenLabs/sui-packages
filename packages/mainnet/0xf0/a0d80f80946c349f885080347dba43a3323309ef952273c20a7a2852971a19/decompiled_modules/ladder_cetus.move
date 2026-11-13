module 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder_cetus {
    public fun collect_reward<T0, T1, T2>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 1);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::pay_reward<T0, T1, T2>(arg0, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::borrow_any_mut<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg4), arg3, true, arg5), arg6);
    }

    public fun add<T0, T1>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Ticket, arg1: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = false;
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 1);
        assert!(0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::quote_first<T0, T1>(arg1) == v0, 743);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v2), 740);
        let v3 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::tick_spacing<T0, T1>(arg1);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::is_valid_index(v1, v3) && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::is_valid_index(v2, v3), 740);
        let (v4, v5) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::token_bounds(v1, v2, v0);
        let (v6, _) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::takes(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3), v1, v2, v0);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::check_bid<T0, T1>(arg0, arg1, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::token_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3), v0), v4, v5, v6, arg6);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, arg4, arg5, arg8);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg3, &mut v8, arg6, v0, arg7);
        let (v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v9);
        let (v12, v13) = if (v0) {
            (v11, v10)
        } else {
            (v10, v11)
        };
        assert!(v12 == 0, 742);
        let v14 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::take_idle_q<T0, T1>(arg1);
        assert!(0x2::balance::value<T1>(&v14) >= v13, 742);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v14, v13), v9);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::record_bid<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, v8, arg4, arg5, v12, v13, v14);
    }

    public fun add_qf<T0, T1>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Ticket, arg1: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: u32, arg5: u32, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = true;
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), 1);
        assert!(0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::quote_first<T0, T1>(arg1) == v0, 743);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v2), 740);
        let v3 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::tick_spacing<T0, T1>(arg1);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::is_valid_index(v1, v3) && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::is_valid_index(v2, v3), 740);
        let (v4, v5) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::token_bounds(v1, v2, v0);
        let (v6, _) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::takes(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T1, T0>(arg3), v1, v2, v0);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::check_bid<T0, T1>(arg0, arg1, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::token_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg3), v0), v4, v5, v6, arg6);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T1, T0>(arg2, arg3, arg4, arg5, arg8);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T1, T0>(arg2, arg3, &mut v8, arg6, v0, arg7);
        let (v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T1, T0>(&v9);
        let (v12, v13) = if (v0) {
            (v11, v10)
        } else {
            (v10, v11)
        };
        assert!(v12 == 0, 742);
        let v14 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::take_idle_q<T0, T1>(arg1);
        assert!(0x2::balance::value<T1>(&v14) >= v13, 742);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T1, T0>(arg2, arg3, 0x2::balance::split<T1>(&mut v14, v13), 0x2::balance::zero<T0>(), v9);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::record_bid<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, v8, arg4, arg5, v12, v13, v14);
    }

    public fun begin<T0, T1, T2>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T2>, arg1: &0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg3: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Ticket {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T2>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg4), 1);
        assert!(0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::quote_first<T0, T2>(arg0) == false, 743);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::start_ticket<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg4), v0, arg6);
        let v2 = arg0;
        let v3 = false;
        let (v4, v5) = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::idle<T0, T2>(v2);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::ranges<T0, T2>(v2);
        if (!0x1::vector::is_empty<0x2::object::ID>(&v8)) {
            let v9 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::token_sqrt(v1, v3);
            0x1::vector::reverse<0x2::object::ID>(&mut v8);
            let v10 = 0;
            while (v10 < 0x1::vector::length<0x2::object::ID>(&v8)) {
                let v11 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::borrow_range<T0, T2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v2, 0x1::vector::pop_back<0x2::object::ID>(&mut v8));
                let (v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v11);
                let (v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(v12, v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(v9), v9, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v11), false);
                let (v16, v17) = if (v3) {
                    (v15, v14)
                } else {
                    (v14, v15)
                };
                v7 = v7 + v16;
                v6 = v6 + v17;
                v10 = v10 + 1;
            };
            0x1::vector::destroy_empty<0x2::object::ID>(v8);
        };
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::make_ticket<T0, T2>(arg0, v1, v7, v6, v0)
    }

    public fun begin_qf<T0, T1, T2>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T2>, arg1: &0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg3: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Ticket {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T2>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg4), 1);
        assert!(0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::quote_first<T0, T2>(arg0) == true, 743);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::start_ticket<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg4), v0, arg6);
        let v2 = arg0;
        let v3 = true;
        let (v4, v5) = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::idle<T0, T2>(v2);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::ranges<T0, T2>(v2);
        if (!0x1::vector::is_empty<0x2::object::ID>(&v8)) {
            let v9 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::token_sqrt(v1, v3);
            0x1::vector::reverse<0x2::object::ID>(&mut v8);
            let v10 = 0;
            while (v10 < 0x1::vector::length<0x2::object::ID>(&v8)) {
                let v11 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::borrow_range<T0, T2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v2, 0x1::vector::pop_back<0x2::object::ID>(&mut v8));
                let (v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v11);
                let (v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(v12, v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(v9), v9, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v11), false);
                let (v16, v17) = if (v3) {
                    (v15, v14)
                } else {
                    (v14, v15)
                };
                v7 = v7 + v16;
                v6 = v6 + v17;
                v10 = v10 + 1;
            };
            0x1::vector::destroy_empty<0x2::object::ID>(v8);
        };
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::make_ticket<T0, T2>(arg0, v1, v7, v6, v0)
    }

    fun check_opened<T0, T1>(arg0: &0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg1: 0x2::object::ID, arg2: bool) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T1>(arg0, arg1, 1);
        assert!(0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::quote_first<T0, T1>(arg0) == arg2, 743);
    }

    public fun close_retired<T0, T1>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::object::ID) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 1);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::is_empty(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T0, T1>(arg2, arg3)), 741);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::pop_retired<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg3));
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::emit_closed<T0, T1>(arg0, arg3);
    }

    public fun close_retired_qf<T0, T1>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: 0x2::object::ID) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2), 1);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::is_empty(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T1, T0>(arg2, arg3)), 741);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T1, T0>(arg1, arg2, 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::pop_retired<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg3));
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::emit_closed<T0, T1>(arg0, arg3);
    }

    public fun collect_reward_qf<T0, T1, T2>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2), 1);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::pay_reward<T0, T1, T2>(arg0, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T1, T0, T2>(arg1, arg2, 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::borrow_any_mut<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg4), arg3, true, arg5), arg6);
    }

    entry fun observe<T0, T1>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg1: &0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_version(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_keeper(arg2, arg5);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 1);
        assert!(0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::quote_first<T0, T1>(arg0) == false, 743);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::record_price<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg4), 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::token_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3), false));
    }

    entry fun observe_qf<T0, T1>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg1: &0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_version(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_keeper(arg2, arg5);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), 1);
        assert!(0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::quote_first<T0, T1>(arg0) == true, 743);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::record_price<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg4), 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::token_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg3), true));
    }

    public fun open<T0, T1, T2>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Registry, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::bundle::Bundle<T0, T2>, arg3: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::new_for_bundle<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T2>(arg4), 0x2::clock::timestamp_ms(arg6), arg7);
        check_opened<T0, T2>(&v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg4), false);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::share<T0, T2>(v0);
    }

    public fun open_curve<T0, T1, T2>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Registry, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::curve_bundle::CurveBundle<T0>, arg3: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::new_for_curve<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T2>(arg4), 0x2::clock::timestamp_ms(arg6), arg7);
        check_opened<T0, T2>(&v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg4), false);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::share<T0, T2>(v0);
    }

    public fun open_qf<T0, T1, T2>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Registry, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::bundle::Bundle<T0, T2>, arg3: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::new_for_bundle<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T2, T0>(arg4), 0x2::clock::timestamp_ms(arg6), arg7);
        check_opened<T0, T2>(&v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg4), true);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::share<T0, T2>(v0);
    }

    public fun remove<T0, T1>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Ticket, arg1: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::object::ID, arg5: u128, arg6: &0x2::clock::Clock) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_ticket<T0, T1>(arg0, arg1);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 1);
        let v0 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::borrow_range_mut<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1, arg4);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, v0, true);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0);
        let v4 = if (arg5 > v3) {
            v3
        } else {
            arg5
        };
        let (v5, v6) = if (v4 > 0) {
            let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, v0, v4, arg6);
            (v8, v7)
        } else {
            (0x2::balance::zero<T1>(), 0x2::balance::zero<T0>())
        };
        let v9 = v4 == v3;
        let v10 = false;
        if (v9) {
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::is_empty(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T0, T1>(arg3, arg4)) && !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T0, T1>(arg3, arg4)) {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg3, 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::pop_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1, arg4));
            } else {
                0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::retire<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1, 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::pop_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1, arg4));
                v10 = true;
            };
        };
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::keep_removed<T0, T1>(arg1, arg4, v4, v6, v5, v1, v2, v9, v10);
    }

    public fun remove_qf<T0, T1>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::Ticket, arg1: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: 0x2::object::ID, arg5: u128, arg6: &0x2::clock::Clock) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_ticket<T0, T1>(arg0, arg1);
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), 1);
        let v0 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::borrow_range_mut<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1, arg4);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T1, T0>(arg2, arg3, v0, true);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0);
        let v4 = if (arg5 > v3) {
            v3
        } else {
            arg5
        };
        let (v5, v6) = if (v4 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T1, T0>(arg2, arg3, v0, v4, arg6)
        } else {
            (0x2::balance::zero<T1>(), 0x2::balance::zero<T0>())
        };
        let v7 = v4 == v3;
        let v8 = false;
        if (v7) {
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::is_empty(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T1, T0>(arg3, arg4)) && !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T1, T0>(arg3, arg4)) {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T1, T0>(arg2, arg3, 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::pop_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1, arg4));
            } else {
                0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::retire<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1, 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::pop_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1, arg4));
                v8 = true;
            };
        };
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::keep_removed<T0, T1>(arg1, arg4, v4, v6, v5, v2, v1, v7, v8);
    }

    public fun unwind<T0, T1, T2>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_can_unwind<T0, T1, T2>(arg0, arg1, 0x2::clock::timestamp_ms(arg5));
        let v0 = 340282366920938463463374607431768211455;
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T2>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg3), 1);
        let v1 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::borrow_range_mut<T0, T2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg4);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T2>(arg2, arg3, v1, true);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v1);
        let v5 = if (v0 > v4) {
            v4
        } else {
            v0
        };
        let (v6, v7) = if (v5 > 0) {
            let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T2>(arg2, arg3, v1, v5, arg5);
            (v9, v8)
        } else {
            (0x2::balance::zero<T2>(), 0x2::balance::zero<T0>())
        };
        let v10 = v5 == v4;
        let v11 = false;
        if (v10) {
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::is_empty(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T0, T2>(arg3, arg4)) && !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T0, T2>(arg3, arg4)) {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T2>(arg2, arg3, 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::pop_range<T0, T2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg4));
            } else {
                0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::retire<T0, T2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::pop_range<T0, T2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg4));
                v11 = true;
            };
        };
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::keep_removed<T0, T2>(arg0, arg4, v5, v7, v6, v2, v3, v10, v11);
    }

    public fun unwind_qf<T0, T1, T2>(arg0: &mut 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::BuyLadder<T0, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock) {
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_can_unwind<T0, T1, T2>(arg0, arg1, 0x2::clock::timestamp_ms(arg5));
        let v0 = 340282366920938463463374607431768211455;
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::assert_pool<T0, T2>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg3), 1);
        let v1 = 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::borrow_range_mut<T0, T2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg4);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T2, T0>(arg2, arg3, v1, true);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v1);
        let v5 = if (v0 > v4) {
            v4
        } else {
            v0
        };
        let (v6, v7) = if (v5 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T2, T0>(arg2, arg3, v1, v5, arg5)
        } else {
            (0x2::balance::zero<T2>(), 0x2::balance::zero<T0>())
        };
        let v8 = v5 == v4;
        let v9 = false;
        if (v8) {
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::is_empty(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T2, T0>(arg3, arg4)) && !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T2, T0>(arg3, arg4)) {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T2, T0>(arg2, arg3, 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::pop_range<T0, T2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg4));
            } else {
                0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::retire<T0, T2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::pop_range<T0, T2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg4));
                v9 = true;
            };
        };
        0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder::keep_removed<T0, T2>(arg0, arg4, v5, v7, v6, v3, v2, v8, v9);
    }

    // decompiled from Move bytecode v7
}

