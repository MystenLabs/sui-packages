module 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::cetus_manager {
    struct PositionManager has store {
        positions: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        lower_tick: u32,
        upper_tick: u32,
        need_rebalance: bool,
        claimed_fees_at: u64,
        claimed_reward_at: u64,
        is_core: bool,
    }

    struct Assets<phantom T0, phantom T1> has store {
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        fee_a: 0x2::balance::Balance<T0>,
        fee_b: 0x2::balance::Balance<T1>,
        rewards: 0x2::bag::Bag,
    }

    struct CetusManager<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        core_position: PositionManager,
        core_assets: Assets<T0, T1>,
        profit_position: PositionManager,
        profit_assets: Assets<T0, T1>,
    }

    struct PositionCreated has copy, drop {
        position_id: 0x2::object::ID,
        is_core: bool,
    }

    struct PositionClosed has copy, drop {
        position_id: 0x2::object::ID,
        is_core: bool,
    }

    struct LiquidityAdded has copy, drop {
        position_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        value_added: u64,
        is_new_position: bool,
    }

    struct LiquidityRemoved has copy, drop {
        position_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        value_removed: u64,
    }

    struct BalanceAdjusted has copy, drop {
        is_core: bool,
        amount_a_before: u64,
        amount_b_before: u64,
        amount_a_after: u64,
        amount_b_after: u64,
        swapped_amount: u64,
        is_a_to_b: bool,
    }

    public(friend) fun close_position<T0, T1>(arg0: &mut CetusManager<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: u8) {
        let (v0, v1) = if (arg3) {
            let v1 = &mut arg0.core_assets;
            let v0 = &mut arg0.core_position;
            (v0, v1)
        } else {
            let v1 = &mut arg0.profit_assets;
            let v0 = &mut arg0.profit_position;
            (v0, v1)
        };
        assert!((arg4 as u64) < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0.positions), 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::invalid_offset());
        let v2 = 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0.positions) - 1 - (arg4 as u64);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::info_liquidity(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T0, T1>(arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0.positions, v2)))) == 0) {
            let v3 = 0x1::vector::remove<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v0.positions, v2);
            let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &v3, true);
            0x2::balance::join<T0>(&mut v1.fee_a, v4);
            0x2::balance::join<T1>(&mut v1.fee_b, v5);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v3);
            let v6 = PositionClosed{
                position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v3),
                is_core     : arg3,
            };
            0x2::event::emit<PositionClosed>(v6);
        };
    }

    public(friend) fun collect_reward<T0, T1, T2>(arg0: &mut CetusManager<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: u8, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: &0x2::clock::Clock) {
        let (v0, v1) = if (arg3) {
            (&mut arg0.core_position, &mut arg0.core_assets)
        } else {
            (&mut arg0.profit_position, &mut arg0.profit_assets)
        };
        let v2 = borrow_position_mut(v0, arg4);
        let v3 = 0x1::type_name::get<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&v1.rewards, v3)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v1.rewards, v3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, v2, arg5, true, arg6));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v1.rewards, v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, v2, arg5, true, arg6));
        };
        v0.claimed_reward_at = 0x2::clock::timestamp_ms(arg6);
    }

    public(friend) fun flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, true, arg5, calculate_sqrt_price_limit<T0, T1>(arg1, arg6, arg4), arg7);
        let v3 = v1;
        let v4 = v0;
        if (arg4) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T1>(), v2);
            0x2::balance::join<T1>(&mut v3, arg3);
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), arg3, v2);
            0x2::balance::join<T0>(&mut v4, arg2);
        };
        (v4, v3)
    }

    public(friend) fun get_liquidity_from_amount<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u32, arg2: u32, arg3: u64, arg4: bool) : (u128, u64, u64) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), arg3, arg4)
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut PositionManager, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock) : (u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = borrow_position_mut(arg0, 0);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, v0, arg3, arg4);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::balance::value<T0>(&v4);
        let v6 = 0x2::balance::value<T1>(&v3);
        let v7 = tokens_value<T0, T1>(arg2, v5, v6);
        let v8 = LiquidityRemoved{
            position_id   : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0),
            amount_a      : v5,
            amount_b      : v6,
            value_removed : v7,
        };
        0x2::event::emit<LiquidityRemoved>(v8);
        (v7, v4, v3)
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: &mut PositionManager, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2::balance::Balance<T0>, arg4: &mut 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = arg0.is_core;
        let v1 = arg0.lower_tick;
        let v2 = arg0.upper_tick;
        let (v3, v4) = if (!arg0.need_rebalance) {
            (borrow_position_mut(arg0, 0), false)
        } else {
            arg0.need_rebalance = false;
            0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, v1, v2, arg6));
            (borrow_position_mut(arg0, 0), true)
        };
        let v5 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v3);
        if (v4) {
            let v6 = PositionCreated{
                position_id : v5,
                is_core     : v0,
            };
            0x2::event::emit<PositionCreated>(v6);
        };
        let v7 = 0x2::balance::value<T0>(arg3);
        let v8 = 0x2::balance::value<T1>(arg4);
        let (_, v10) = calculate_optimal_swap<T0, T1>(arg2, v7, v8, v1, v2, true);
        let v11 = if (v10) {
            v8
        } else {
            v7
        };
        let v12 = v10 && false || true;
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, v3, v11, v12, arg5);
        let (v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v13);
        assert!(v7 >= v14 && v8 >= v15, 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::invalid_amount());
        let v16 = if (v14 > 0) {
            0x2::balance::split<T0>(arg3, v14)
        } else {
            0x2::balance::zero<T0>()
        };
        let v17 = if (v15 > 0) {
            0x2::balance::split<T1>(arg4, v15)
        } else {
            0x2::balance::zero<T1>()
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, v16, v17, v13);
        let v18 = tokens_value<T0, T1>(arg2, v14, v15);
        let v19 = LiquidityAdded{
            position_id     : v5,
            amount_a        : v14,
            amount_b        : v15,
            value_added     : v18,
            is_new_position : v4,
        };
        0x2::event::emit<LiquidityAdded>(v19);
        (v18, v14, v15)
    }

    public(friend) fun adjust_balance<T0, T1>(arg0: &PositionManager, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2::balance::Balance<T0>, arg4: &mut 0x2::balance::Balance<T1>, arg5: u64, arg6: &0x2::clock::Clock) : (u64, u64) {
        let (v0, v1) = calculate_optimal_swap<T0, T1>(arg2, 0x2::balance::value<T0>(arg3), 0x2::balance::value<T1>(arg4), arg0.lower_tick, arg0.upper_tick, false);
        if (v0 > 0) {
            let (v2, v3) = if (v1) {
                (0x2::balance::split<T0>(arg3, v0), 0x2::balance::zero<T1>())
            } else {
                (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg4, v0))
            };
            let (v4, v5) = flash_swap<T0, T1>(arg1, arg2, v2, v3, v1, v0, arg5, arg6);
            0x2::balance::join<T0>(arg3, v4);
            0x2::balance::join<T1>(arg4, v5);
        };
        let v6 = 0x2::balance::value<T0>(arg3);
        let v7 = 0x2::balance::value<T1>(arg4);
        let v8 = BalanceAdjusted{
            is_core         : arg0.is_core,
            amount_a_before : 0x2::balance::value<T0>(arg3),
            amount_b_before : 0x2::balance::value<T1>(arg4),
            amount_a_after  : v6,
            amount_b_after  : v7,
            swapped_amount  : v0,
            is_a_to_b       : v1,
        };
        0x2::event::emit<BalanceAdjusted>(v8);
        (v6, v7)
    }

    public(friend) fun borrow_balances_mut<T0, T1>(arg0: &mut CetusManager<T0, T1>, arg1: bool) : (&mut 0x2::balance::Balance<T0>, &mut 0x2::balance::Balance<T1>) {
        if (arg1) {
            (&mut arg0.core_assets.balance_a, &mut arg0.core_assets.balance_b)
        } else {
            (&mut arg0.profit_assets.balance_a, &mut arg0.profit_assets.balance_b)
        }
    }

    public(friend) fun borrow_position_manager_mut<T0, T1>(arg0: &mut CetusManager<T0, T1>, arg1: bool) : &mut PositionManager {
        if (arg1) {
            &mut arg0.core_position
        } else {
            &mut arg0.profit_position
        }
    }

    public(friend) fun borrow_position_mut(arg0: &mut PositionManager, arg1: u8) : &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        assert!((arg1 as u64) < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions), 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::invalid_offset());
        0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions, 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions) - 1 - (arg1 as u64))
    }

    fun calculate_optimal_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u32, arg4: u32, arg5: bool) : (u64, bool) {
        assert!(arg1 > 0 || arg2 > 0, 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::invalid_amount());
        let v0 = 1000000000;
        let v1 = tokens_value<T0, T1>(arg0, arg1, arg2);
        let v2 = if (!arg5) {
            if ((v1 as u128) > v0 * 10) {
                v0
            } else {
                100000000
            }
        } else {
            0
        };
        let (_, v4, v5) = get_liquidity_from_amount<T0, T1>(arg0, arg3, arg4, (v0 as u64), false);
        let v6 = (arg2 as u128) * v0 / (v1 as u128);
        let v7 = (((v5 as u128) + v2) as u128) * v0 / (tokens_value<T0, T1>(arg0, v4, v5) as u128);
        if (v6 == v7) {
            return (0, true)
        };
        if (v6 < v7) {
            ((((arg1 as u128) * (v7 - v6) / (v0 - v6)) as u64), true)
        } else {
            ((((arg2 as u128) * (v6 - v7) / v6) as u64), false)
        }
    }

    public(friend) fun calculate_reasonable_tick_range<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u32, arg2: u32) : (u32, u32) {
        if (arg1 == 0 && arg2 == 0) {
            return (0, 0)
        };
        assert!(arg1 < 10000, 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::invalid_tick_range());
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(v0 * ((10000 - arg1) as u128) / 10000);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(v0 * ((10000 + arg2) as u128) / 10000);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg0) as u32));
        let v4 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(v1)) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v1, v3), v3), v3)
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v1, v3), v3)
        };
        let v5 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(v2)) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v2, v3), v3)
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v2, v3), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1)), v3)
        };
        let v6 = v5;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v5, v4)) {
            v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v4, v3);
        };
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v4), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v6))
    }

    fun calculate_sqrt_price_limit<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: bool) : u128 {
        let v0 = if (arg2) {
            (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0) as u256) * ((10000 - arg1) as u256) / 10000
        } else {
            (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0) as u256) * ((10000 + arg1) as u256) / 10000
        };
        (v0 as u128)
    }

    public(friend) fun collect_fees<T0, T1>(arg0: &mut CetusManager<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: u8, arg5: &0x2::clock::Clock) {
        let (v0, v1) = if (arg3) {
            (&mut arg0.core_position, &mut arg0.core_assets)
        } else {
            (&mut arg0.profit_position, &mut arg0.profit_assets)
        };
        let v2 = borrow_position_mut(v0, arg4);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, v2, true);
        0x2::balance::join<T0>(&mut v1.fee_a, v3);
        0x2::balance::join<T1>(&mut v1.fee_b, v4);
        v0.claimed_fees_at = 0x2::clock::timestamp_ms(arg5);
    }

    public(friend) fun create_cetus_manager<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = calculate_reasonable_tick_range<T0, T1>(arg0, 2000, 2000);
        let v2 = 0x2::object::new(arg1);
        let v3 = new_assets<T0, T1>(arg1);
        let v4 = CetusManager<T0, T1>{
            id              : v2,
            core_position   : new_position_manager(v0, v1, true),
            core_assets     : v3,
            profit_position : new_position_manager(v0, v1, false),
            profit_assets   : new_assets<T0, T1>(arg1),
        };
        0x2::transfer::share_object<CetusManager<T0, T1>>(v4);
        0x2::object::uid_to_inner(&v4.id)
    }

    public fun current_position_id(arg0: &PositionManager) : 0x1::option::Option<0x2::object::ID> {
        if (0x1::vector::is_empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions)) {
            0x1::option::none<0x2::object::ID>()
        } else {
            0x1::option::some<0x2::object::ID>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions, 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions) - 1)))
        }
    }

    public(friend) fun current_price_range<T0, T1>(arg0: &mut CetusManager<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool) : (u128, u128, u128) {
        let v0 = borrow_position_manager_mut<T0, T1>(arg0, arg2);
        (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v0.lower_tick)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v0.upper_tick)))
    }

    public(friend) fun fees_add_liquidity<T0, T1>(arg0: &mut CetusManager<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let (v0, v1) = if (arg3) {
            (&mut arg0.profit_position, &mut arg0.core_assets)
        } else {
            (&mut arg0.profit_position, &mut arg0.profit_assets)
        };
        let v2 = &mut v1.fee_a;
        let v3 = &mut v1.fee_b;
        let (_, _) = adjust_balance<T0, T1>(v0, arg1, arg2, v2, v3, arg4, arg5);
        let v6 = &mut v1.fee_a;
        let v7 = &mut v1.fee_b;
        add_liquidity<T0, T1>(v0, arg1, arg2, v6, v7, arg5, arg6)
    }

    fun new_assets<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : Assets<T0, T1> {
        Assets<T0, T1>{
            balance_a : 0x2::balance::zero<T0>(),
            balance_b : 0x2::balance::zero<T1>(),
            fee_a     : 0x2::balance::zero<T0>(),
            fee_b     : 0x2::balance::zero<T1>(),
            rewards   : 0x2::bag::new(arg0),
        }
    }

    public(friend) fun new_position_manager(arg0: u32, arg1: u32, arg2: bool) : PositionManager {
        PositionManager{
            positions         : 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            lower_tick        : arg0,
            upper_tick        : arg1,
            need_rebalance    : true,
            claimed_fees_at   : 0,
            claimed_reward_at : 0,
            is_core           : arg2,
        }
    }

    public entry fun pool_info<T0, T1>(arg0: &mut CetusManager<T0, T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (u128, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        let (v0, v1, v2, v3, v4, v5, v6) = pool_value<T0, T1>(arg0, arg1, arg2);
        let v7 = if (arg2) {
            &arg0.core_assets
        } else {
            &arg0.profit_assets
        };
        let v8 = 0x2::balance::value<T0>(&v7.fee_a);
        let v9 = 0x2::balance::value<T1>(&v7.fee_b);
        (v0, v1, v2, v3, v4, v5, v6, v8, v9, tokens_value<T0, T1>(arg1, v8, v9))
    }

    public(friend) fun pool_value<T0, T1>(arg0: &mut CetusManager<T0, T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool) : (u128, u64, u64, u64, u64, u64, u64) {
        let v0 = borrow_position_manager_mut<T0, T1>(arg0, arg2);
        let v1 = current_position_id(v0);
        if (0x1::option::is_none<0x2::object::ID>(&v1)) {
            return (0, 0, 0, 0, 0, 0, 0)
        };
        let (v2, v3) = if (0x1::option::is_some<0x2::object::ID>(&v1)) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_amounts<T0, T1>(arg1, *0x1::option::borrow<0x2::object::ID>(&v1))
        } else {
            (0, 0)
        };
        let v4 = if (arg2) {
            &arg0.core_assets
        } else {
            &arg0.profit_assets
        };
        let v5 = 0x2::balance::value<T0>(&v4.balance_a);
        let v6 = 0x2::balance::value<T1>(&v4.balance_b);
        (total_liquidity<T0, T1>(v0, arg1), v2, v3, tokens_value<T0, T1>(arg1, v2, v3), v5, v6, tokens_value<T0, T1>(arg1, v5, v6))
    }

    public(friend) fun rebalance<T0, T1>(arg0: &mut CetusManager<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: u32, arg5: u32, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = if (arg3) {
            let v1 = &mut arg0.core_assets;
            let v0 = &mut arg0.core_position;
            (v0, v1)
        } else {
            let v1 = &mut arg0.profit_assets;
            let v0 = &mut arg0.profit_position;
            (v0, v1)
        };
        let v2 = 0x2::clock::timestamp_ms(arg7) - 600000;
        assert!(v0.claimed_fees_at > v2 && v0.claimed_reward_at > v2, 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::invalid_state());
        let v3 = total_liquidity<T0, T1>(v0, arg2);
        if (v3 > 0) {
            let (_, v5, v6) = remove_liquidity<T0, T1>(v0, arg1, arg2, v3, arg7);
            0x2::balance::join<T0>(&mut v1.balance_a, v5);
            0x2::balance::join<T1>(&mut v1.balance_b, v6);
        };
        if ((arg4 != v0.lower_tick || arg5 != v0.upper_tick) && arg4 != 0 && arg5 != 0) {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5)), 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::invalid_tick_range());
            v0.lower_tick = arg4;
            v0.upper_tick = arg5;
            v0.need_rebalance = true;
        };
        let v7 = &mut v1.balance_a;
        let v8 = &mut v1.balance_b;
        let (_, _) = adjust_balance<T0, T1>(v0, arg1, arg2, v7, v8, arg6, arg7);
        let v11 = &mut v1.balance_a;
        let v12 = &mut v1.balance_b;
        let (_, _, _) = add_liquidity<T0, T1>(v0, arg1, arg2, v11, v12, arg7, arg8);
    }

    public(friend) fun swap_c_for_b<T0, T1, T2>(arg0: &mut CetusManager<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = if (arg3) {
            &mut arg0.core_assets
        } else {
            &mut arg0.profit_assets
        };
        let v1 = 0x1::type_name::get<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&v0.rewards, v1)) {
            let v2 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v0.rewards, v1);
            let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg1, arg2, true, true, 0x2::balance::value<T2>(&v2), calculate_sqrt_price_limit<T2, T1>(arg2, arg4, true), arg5);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg1, arg2, v2, 0x2::balance::zero<T1>(), v5);
            0x2::balance::join<T1>(&mut v0.fee_b, v4);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v0.rewards, v1, v3);
        };
    }

    public(friend) fun tokens_value<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        (((arg1 as u256) * (v0 as u256) * (v0 as u256) / (340282366920938463463374607431768211455 as u256)) as u64) + arg2
    }

    public fun total_liquidity<T0, T1>(arg0: &PositionManager, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u128 {
        if (0x1::vector::is_empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions)) {
            return 0
        };
        let v0 = current_position_id(arg0);
        if (0x1::option::is_none<0x2::object::ID>(&v0)) {
            return 0
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::info_liquidity(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T0, T1>(arg1, *0x1::option::borrow<0x2::object::ID>(&v0)))
    }

    public(friend) fun transfer_reward<T0, T1>(arg0: &mut CetusManager<T0, T1>, arg1: bool) {
        let v0 = if (arg1) {
            &mut arg0.core_assets
        } else {
            &mut arg0.profit_assets
        };
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&v0.rewards, v1)) {
            0x2::balance::join<T0>(&mut v0.fee_a, 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.rewards, v1));
        };
        let v2 = 0x1::type_name::get<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&v0.rewards, v2)) {
            0x2::balance::join<T1>(&mut v0.fee_b, 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v0.rewards, v2));
        };
    }

    // decompiled from Move bytecode v6
}

