module 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus {
    public(friend) fun add_qf<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Ticket, arg1: &mut 0x2::object::UID, arg2: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Added {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4), 1);
        let v0 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::quote_first<T0, T1>(arg2);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v2), 407);
        let v3 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::tick_spacing<T0, T1>(arg2);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::is_valid_index(v1, v3) && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::is_valid_index(v2, v3), 407);
        let (v4, v5) = token_bounds(v1, v2, v0);
        let (v6, v7) = takes(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T1, T0>(arg4), v1, v2, v0);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::check_add<T0, T1>(arg0, arg2, token_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg4), v0), v4, v5, v6, v7, arg7, arg8);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T1, T0>(arg3, arg4, arg5, arg6, arg11);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T1, T0>(arg3, arg4, &mut v8, arg7, arg8 != v0, arg10);
        let (v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T1, T0>(&v9);
        let (v12, v13) = if (v0) {
            (v11, v10)
        } else {
            (v10, v11)
        };
        let (v14, v15) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::take_for_add<T0, T1>(arg2, v6, v7);
        let v16 = v15;
        let v17 = v14;
        assert!(0x2::balance::value<T0>(&v17) >= v12 && 0x2::balance::value<T1>(&v16) >= v13, 425);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T1, T0>(arg3, arg4, 0x2::balance::split<T1>(&mut v16, v13), 0x2::balance::split<T0>(&mut v17, v12), v9);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::record_add<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg2, v8, arg5, arg6, v12, v13, v17, v16, arg8, arg9)
    }

    public(friend) fun add_tf<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Ticket, arg1: &mut 0x2::object::UID, arg2: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Added {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4), 1);
        let v0 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::quote_first<T0, T1>(arg2);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v2), 407);
        let v3 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::tick_spacing<T0, T1>(arg2);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::is_valid_index(v1, v3) && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::is_valid_index(v2, v3), 407);
        let (v4, v5) = token_bounds(v1, v2, v0);
        let (v6, v7) = takes(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg4), v1, v2, v0);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::check_add<T0, T1>(arg0, arg2, token_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg4), v0), v4, v5, v6, v7, arg7, arg8);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg3, arg4, arg5, arg6, arg11);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg3, arg4, &mut v8, arg7, arg8 != v0, arg10);
        let (v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v9);
        let (v12, v13) = if (v0) {
            (v11, v10)
        } else {
            (v10, v11)
        };
        let (v14, v15) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::take_for_add<T0, T1>(arg2, v6, v7);
        let v16 = v15;
        let v17 = v14;
        assert!(0x2::balance::value<T0>(&v17) >= v12 && 0x2::balance::value<T1>(&v16) >= v13, 425);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg3, arg4, 0x2::balance::split<T0>(&mut v17, v12), 0x2::balance::split<T1>(&mut v16, v13), v9);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::record_add<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg2, v8, arg5, arg6, v12, v13, v17, v16, arg8, arg9)
    }

    public(friend) fun amounts<T0, T1>(arg0: &0x2::object::UID, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>, arg2: u128) : (u64, u64) {
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::idle<T0, T1>(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_count<T0, T1>(arg1);
        if (v4 == 0) {
            return (v0, v1)
        };
        let v5 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::quote_first<T0, T1>(arg1);
        let v6 = token_sqrt(arg2, v5);
        let v7 = 0;
        while (v7 < v4) {
            let v8 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::borrow_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, v7);
            let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v8);
            let (v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(v9, v10, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(v6), v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v8), false);
            let (v13, v14) = if (v5) {
                (v12, v11)
            } else {
                (v11, v12)
            };
            v3 = v3 + v13;
            v2 = v2 + v14;
            v7 = v7 + 1;
        };
        (v3, v2)
    }

    public(friend) fun begin<T0, T1>(arg0: &0x2::object::UID, arg1: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>, arg2: 0x2::object::ID, arg3: u64) : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Ticket {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(arg1, arg2, 1);
        let v0 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::prepare_ticket<T0, T1>(arg1, arg3);
        let (v1, v2) = amounts<T0, T1>(arg0, arg1, v0);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::make_ticket(arg0, v0, v1, v2, arg3)
    }

    public(friend) fun close_retired_qf<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: u64) : 0x2::object::ID {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), 1);
        let v0 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::pop_retired<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::is_empty(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T1, T0>(arg3, v1)), 421);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T1, T0>(arg2, arg3, v0);
        v1
    }

    public(friend) fun close_retired_tf<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64) : 0x2::object::ID {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 1);
        let v0 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::pop_retired<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::is_empty(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T0, T1>(arg3, v1)), 421);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg3, v0);
        v1
    }

    public(friend) fun collect_range_fees_qf<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), 1);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T1, T0>(arg2, arg3, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::borrow_range_mut<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4), true);
        (v1, v0)
    }

    public(friend) fun collect_range_fees_tf<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::borrow_range_mut<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4), true)
    }

    public(friend) fun collect_reward_qf<T0, T1, T2>(arg0: &mut 0x2::object::UID, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T1, T0, T2>(arg2, arg3, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::borrow_any_mut<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg5), arg4, true, arg6)
    }

    public(friend) fun collect_reward_tf<T0, T1, T2>(arg0: &mut 0x2::object::UID, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg2, arg3, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::borrow_any_mut<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg5), arg4, true, arg6)
    }

    public fun crossed(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: bool) : bool {
        arg3 && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, arg1) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg0, arg2)
    }

    public fun first_over(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg1);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(arg0, v0);
        let v2 = v1;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(v1)) {
            v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, v0);
        };
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0, v2), v0)
    }

    public fun flip_sqrt(arg0: u128) : u128 {
        let v0 = 340282366920938463463374607431768211456 / (arg0 as u256);
        if (v0 > (340282366920938463463374607431768211455 as u256)) {
            340282366920938463463374607431768211455
        } else {
            (v0 as u128)
        }
    }

    public fun ladder_base(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        let v0 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(arg1, arg0)) {
            arg1
        } else {
            arg0
        };
        first_over(v0, arg2)
    }

    public fun neg(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero(), arg0)
    }

    public(friend) fun place_launch_ladder_qf<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Added> {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), 1);
        let v0 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::quote_first<T0, T1>(arg1);
        let (v1, v2, v3) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::ladder_shape();
        let v4 = v1;
        let v5 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::tick_spacing<T0, T1>(arg1);
        let v6 = if (v0) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(neg(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T1, T0>(arg3)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T1, T0>(arg3)
        };
        let (v7, _) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::idle<T0, T1>(arg1);
        let v9 = 0x1::vector::length<u32>(&v4);
        let v10 = (((v7 as u128) * (v3 as u128) / 10000 / (v9 as u128)) as u64);
        let v11 = 0x1::vector::empty<0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Added>();
        let v12 = 0;
        while (v12 < v9) {
            let v13 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(ladder_base(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(arg4), v6, v5), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(*0x1::vector::borrow<u32>(&v4, v12)));
            let (v14, v15) = if (v0) {
                (neg(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v13, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v2))), neg(v13))
            } else {
                (v13, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v13, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v2)))
            };
            let v16 = if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::is_valid_index(v14, v5) && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::is_valid_index(v15, v5)) {
                if (v10 > 0) {
                    token_only(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T1, T0>(arg3), v14, v15, v0)
                } else {
                    false
                }
            } else {
                false
            };
            if (v16) {
                let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T1, T0>(arg2, arg3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v14), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v15), arg6);
                let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T1, T0>(arg2, arg3, &mut v17, v10, !v0, arg5);
                let (v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T1, T0>(&v18);
                let v21 = if (v0) {
                    v20
                } else {
                    v19
                };
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T1, T0>(arg2, arg3, 0x2::balance::zero<T1>(), 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::split_t<T0, T1>(arg1, v21), v18);
                0x1::vector::push_back<0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Added>(&mut v11, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::new_added(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::push_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, v17), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v14), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v15), v21, 0));
            };
            v12 = v12 + 1;
        };
        v11
    }

    public(friend) fun place_launch_ladder_tf<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Added> {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 1);
        let v0 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::quote_first<T0, T1>(arg1);
        let (v1, v2, v3) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::ladder_shape();
        let v4 = v1;
        let v5 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::tick_spacing<T0, T1>(arg1);
        let v6 = if (v0) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(neg(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3)
        };
        let (v7, _) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::idle<T0, T1>(arg1);
        let v9 = 0x1::vector::length<u32>(&v4);
        let v10 = (((v7 as u128) * (v3 as u128) / 10000 / (v9 as u128)) as u64);
        let v11 = 0x1::vector::empty<0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Added>();
        let v12 = 0;
        while (v12 < v9) {
            let v13 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(ladder_base(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(arg4), v6, v5), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(*0x1::vector::borrow<u32>(&v4, v12)));
            let (v14, v15) = if (v0) {
                (neg(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v13, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v2))), neg(v13))
            } else {
                (v13, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v13, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v2)))
            };
            let v16 = if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::is_valid_index(v14, v5) && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::is_valid_index(v15, v5)) {
                if (v10 > 0) {
                    token_only(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3), v14, v15, v0)
                } else {
                    false
                }
            } else {
                false
            };
            if (v16) {
                let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v14), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v15), arg6);
                let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg3, &mut v17, v10, !v0, arg5);
                let (v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v18);
                let v21 = if (v0) {
                    v20
                } else {
                    v19
                };
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg3, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::split_t<T0, T1>(arg1, v21), 0x2::balance::zero<T1>(), v18);
                0x1::vector::push_back<0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Added>(&mut v11, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::new_added(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::push_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, v17), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v14), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v15), v21, 0));
            };
            v12 = v12 + 1;
        };
        v11
    }

    public(friend) fun range_liquidity<T0, T1>(arg0: &0x2::object::UID, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>, arg2: u64) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::borrow_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg2))
    }

    public(friend) fun reclaim_crossed_qf<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: u64, arg5: &0x2::clock::Clock) : (0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Removed, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), 1);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::borrow_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4));
        assert!(crossed(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T1, T0>(arg3), v0, v1, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::quote_first<T0, T1>(arg1)), 423);
        let v2 = 340282366920938463463374607431768211455;
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), 1);
        let v3 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_id<T0, T1>(arg1, arg4);
        let v4 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::borrow_range_mut<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T1, T0>(arg2, arg3, v4, true);
        let v7 = v5;
        let v8 = v6;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v4);
        let v10 = if (v2 > v9) {
            v9
        } else {
            v2
        };
        let (v11, v12) = if (v10 > 0) {
            let (v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T1, T0>(arg2, arg3, v4, v10, arg5);
            (v14, v13)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v15 = v12;
        let v16 = v11;
        let v17 = v10 == v9;
        let v18 = false;
        if (v17) {
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::is_empty(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T1, T0>(arg3, v3)) && !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T1, T0>(arg3, v3)) {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T1, T0>(arg2, arg3, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::pop_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4));
            } else {
                0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::retire<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::pop_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4));
                v18 = true;
            };
        };
        (0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::new_removed(v3, v10, 0x2::balance::value<T0>(&v16), 0x2::balance::value<T1>(&v15), 0x2::balance::value<T0>(&v8), 0x2::balance::value<T1>(&v7), v17, v18), v16, v15, v8, v7)
    }

    public(friend) fun reclaim_crossed_tf<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock) : (0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Removed, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 1);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::borrow_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4));
        assert!(crossed(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3), v0, v1, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::quote_first<T0, T1>(arg1)), 423);
        let v2 = 340282366920938463463374607431768211455;
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 1);
        let v3 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_id<T0, T1>(arg1, arg4);
        let v4 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::borrow_range_mut<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, v4, true);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v4);
        let v10 = if (v2 > v9) {
            v9
        } else {
            v2
        };
        let (v11, v12) = if (v10 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, v4, v10, arg5)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v13 = v12;
        let v14 = v11;
        let v15 = v10 == v9;
        let v16 = false;
        if (v15) {
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::is_empty(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T0, T1>(arg3, v3)) && !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T0, T1>(arg3, v3)) {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg3, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::pop_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4));
            } else {
                0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::retire<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::pop_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4));
                v16 = true;
            };
        };
        (0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::new_removed(v3, v10, 0x2::balance::value<T0>(&v14), 0x2::balance::value<T1>(&v13), 0x2::balance::value<T0>(&v8), 0x2::balance::value<T1>(&v7), v15, v16), v14, v13, v8, v7)
    }

    public(friend) fun spot_qf<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>) : u128 {
        flip_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg0))
    }

    public(friend) fun spot_tf<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0)
    }

    public(friend) fun take_range_qf<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock) : (0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Removed, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), 1);
        let v0 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_id<T0, T1>(arg1, arg4);
        let v1 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::borrow_range_mut<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T1, T0>(arg2, arg3, v1, true);
        let v4 = v2;
        let v5 = v3;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v1);
        let v7 = if (arg5 > v6) {
            v6
        } else {
            arg5
        };
        let (v8, v9) = if (v7 > 0) {
            let (v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T1, T0>(arg2, arg3, v1, v7, arg6);
            (v11, v10)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v12 = v9;
        let v13 = v8;
        let v14 = v7 == v6;
        let v15 = false;
        if (v14) {
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::is_empty(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T1, T0>(arg3, v0)) && !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T1, T0>(arg3, v0)) {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T1, T0>(arg2, arg3, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::pop_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4));
            } else {
                0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::retire<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::pop_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4));
                v15 = true;
            };
        };
        (0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::new_removed(v0, v7, 0x2::balance::value<T0>(&v13), 0x2::balance::value<T1>(&v12), 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4), v14, v15), v13, v12, v5, v4)
    }

    public(friend) fun take_range_tf<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock) : (0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Removed, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 1);
        let v0 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_id<T0, T1>(arg1, arg4);
        let v1 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::borrow_range_mut<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, v1, true);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v1);
        let v7 = if (arg5 > v6) {
            v6
        } else {
            arg5
        };
        let (v8, v9) = if (v7 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, v1, v7, arg6)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v10 = v9;
        let v11 = v8;
        let v12 = v7 == v6;
        let v13 = false;
        if (v12) {
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::is_empty(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T0, T1>(arg3, v0)) && !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T0, T1>(arg3, v0)) {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg3, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::pop_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4));
            } else {
                0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::retire<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::pop_range<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg4));
                v13 = true;
            };
        };
        (0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::new_removed(v0, v7, 0x2::balance::value<T0>(&v11), 0x2::balance::value<T1>(&v10), 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4), v12, v13), v11, v10, v5, v4)
    }

    public fun takes(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: bool) : (bool, bool) {
        if (!arg3) {
            (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, arg2), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(arg0, arg1))
        } else {
            (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg0, arg1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1)), arg2))
        }
    }

    public fun token_bounds(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: bool) : (u128, u128) {
        if (arg2) {
            (flip_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(arg1)), flip_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(arg0)))
        } else {
            (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(arg1))
        }
    }

    public fun token_only(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: bool) : bool {
        arg3 && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg0, arg2) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, arg1)
    }

    public fun token_sqrt(arg0: u128, arg1: bool) : u128 {
        if (arg1) {
            flip_sqrt(arg0)
        } else {
            arg0
        }
    }

    // decompiled from Move bytecode v7
}

