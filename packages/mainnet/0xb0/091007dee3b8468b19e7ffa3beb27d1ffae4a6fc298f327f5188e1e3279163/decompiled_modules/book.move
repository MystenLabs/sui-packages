module 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::book {
    struct Book<phantom T0, phantom T1> has store {
        pool_id: 0x2::object::ID,
        venue: u8,
        quote_first: bool,
        limits: 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::config::Limits,
        tick_spacing: u32,
        idle_t: 0x2::balance::Balance<T0>,
        idle_q: 0x2::balance::Balance<T1>,
        ranges: vector<0x2::object::ID>,
        retired: vector<0x2::object::ID>,
        observations: 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::Observations,
        turnover: 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::Turnover,
        last_rebalance_ms: u64,
        rebalance_paused: bool,
    }

    struct RangeKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct RetiredKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Ticket {
        owner: 0x2::object::ID,
        ref_sqrt: u128,
        value: u64,
        t_value: u64,
        q_value: u64,
        added: u64,
        now: u64,
    }

    struct Removed has copy, drop {
        position_id: 0x2::object::ID,
        liquidity: u128,
        tokens: u64,
        quote: u64,
        fee_t: u64,
        fee_q: u64,
        closed: bool,
        retired: bool,
    }

    struct Added has copy, drop {
        position_id: 0x2::object::ID,
        lower_tick_bits: u32,
        upper_tick_bits: u32,
        tokens: u64,
        quote: u64,
    }

    struct Finished has copy, drop {
        ref_sqrt: u128,
        value: u64,
        added: u64,
        turnover_24h: u64,
        ranges: u64,
        now: u64,
    }

    public(friend) fun add<T0, T1>(arg0: &mut Ticket, arg1: &mut 0x2::object::UID, arg2: &mut Book<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : Added {
        assert_pool_id<T0, T1>(arg2, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4), 0);
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v1), 407);
        let v2 = arg2.tick_spacing;
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::is_valid_index(v0, v2) && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::is_valid_index(v1, v2), 407);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v3, v1);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v3, v0);
        check_add<T0, T1>(arg0, arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(v0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(v1), v4, v5, arg7, arg8);
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg3, arg4, arg5, arg6, arg11);
        let (v7, v8) = take_for_add<T0, T1>(arg2, v4, v5);
        let (v9, v10, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg10, arg3, arg4, &mut v6, v7, v8, arg7, arg8);
        record_add<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, arg1, arg2, v6, arg5, arg6, v9, v10, v11, v12, arg8, arg9)
    }

    public(friend) fun remove<T0, T1>(arg0: &mut Ticket, arg1: &mut 0x2::object::UID, arg2: &mut Book<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock) : (Removed, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert_ticket(arg0, arg1);
        take_range<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun collect_reward<T0, T1, T2>(arg0: &mut 0x2::object::UID, arg1: &Book<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        assert!(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3) == arg1.pool_id, 400);
        let v0 = if (0x1::vector::contains<0x2::object::ID>(&arg1.ranges, &arg4)) {
            let v1 = RangeKey{id: arg4};
            0x2::dynamic_object_field::borrow_mut<RangeKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, v1)
        } else {
            assert!(0x1::vector::contains<0x2::object::ID>(&arg1.retired, &arg4), 422);
            let v2 = RetiredKey{id: arg4};
            0x2::dynamic_object_field::borrow_mut<RetiredKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, v2)
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg5, arg2, arg3, v0)
    }

    public(friend) fun added_fields(arg0: &Added) : (0x2::object::ID, u32, u32, u64, u64) {
        (arg0.position_id, arg0.lower_tick_bits, arg0.upper_tick_bits, arg0.tokens, arg0.quote)
    }

    public(friend) fun amounts<T0, T1>(arg0: &0x2::object::UID, arg1: &Book<T0, T1>, arg2: u128) : (u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg1.idle_t);
        let v1 = v0;
        let v2 = 0x2::balance::value<T1>(&arg1.idle_q);
        let v3 = v2;
        let v4 = 0x1::vector::length<0x2::object::ID>(&arg1.ranges);
        if (v4 == 0) {
            return (v0, v2)
        };
        let v5 = 0;
        while (v5 < v4) {
            let v6 = RangeKey{id: *0x1::vector::borrow<0x2::object::ID>(&arg1.ranges, v5)};
            let v7 = 0x2::dynamic_object_field::borrow<RangeKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, v6);
            let (v8, v9) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_amount_by_liquidity(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(v7), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(v7), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_tick_at_sqrt_price(arg2), arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v7), false);
            v1 = v1 + v8;
            v3 = v3 + v9;
            v5 = v5 + 1;
        };
        (v1, v3)
    }

    public(friend) fun assert_pool<T0, T1>(arg0: &Book<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) {
        assert!(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1) == arg0.pool_id, 400);
    }

    public(friend) fun assert_pool_id<T0, T1>(arg0: &Book<T0, T1>, arg1: 0x2::object::ID, arg2: u8) {
        assert!(arg0.venue == arg2, 424);
        assert!(arg1 == arg0.pool_id, 400);
    }

    public(friend) fun assert_ticket(arg0: &Ticket, arg1: &0x2::object::UID) {
        assert!(arg0.owner == 0x2::object::uid_to_inner(arg1), 401);
    }

    public(friend) fun begin<T0, T1>(arg0: &0x2::object::UID, arg1: &mut Book<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64) : Ticket {
        assert_pool_id<T0, T1>(arg1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 0);
        let v0 = prepare_ticket<T0, T1>(arg1, arg3);
        let (v1, v2) = amounts<T0, T1>(arg0, arg1, v0);
        make_ticket(arg0, v0, v1, v2, arg3)
    }

    public(friend) fun borrow_any_mut<T0, T1, T2: store + key>(arg0: &mut 0x2::object::UID, arg1: &Book<T0, T1>, arg2: 0x2::object::ID) : &mut T2 {
        if (0x1::vector::contains<0x2::object::ID>(&arg1.ranges, &arg2)) {
            let v1 = RangeKey{id: arg2};
            0x2::dynamic_object_field::borrow_mut<RangeKey, T2>(arg0, v1)
        } else {
            assert!(0x1::vector::contains<0x2::object::ID>(&arg1.retired, &arg2), 422);
            let v2 = RetiredKey{id: arg2};
            0x2::dynamic_object_field::borrow_mut<RetiredKey, T2>(arg0, v2)
        }
    }

    public(friend) fun borrow_range<T0, T1, T2: store + key>(arg0: &0x2::object::UID, arg1: &Book<T0, T1>, arg2: u64) : &T2 {
        let v0 = RangeKey{id: range_id<T0, T1>(arg1, arg2)};
        0x2::dynamic_object_field::borrow<RangeKey, T2>(arg0, v0)
    }

    public(friend) fun borrow_range_mut<T0, T1, T2: store + key>(arg0: &mut 0x2::object::UID, arg1: &Book<T0, T1>, arg2: u64) : &mut T2 {
        let v0 = RangeKey{id: range_id<T0, T1>(arg1, arg2)};
        0x2::dynamic_object_field::borrow_mut<RangeKey, T2>(arg0, v0)
    }

    public(friend) fun check_add<T0, T1>(arg0: &Ticket, arg1: &Book<T0, T1>, arg2: u128, arg3: u128, arg4: u128, arg5: bool, arg6: bool, arg7: u64, arg8: bool) {
        assert!(0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::within_deviation(arg2, arg0.ref_sqrt, 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::config::max_dev_bps(&arg1.limits)), 405);
        assert!(0x1::vector::length<0x2::object::ID>(&arg1.ranges) < 8, 406);
        assert!(arg7 > 0, 415);
        assert!(arg3 < arg4, 407);
        let v0 = &arg1.limits;
        assert!(0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::within_band(arg3, arg4, arg0.ref_sqrt, 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::config::band_low_bps(v0), 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::config::band_high_bps(v0)), 408);
        assert!(0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::side_ok(arg3, arg4, arg0.ref_sqrt, arg5, arg6), 409);
        assert!(arg8 && arg5 || !arg8 && arg6, 412);
        if (arg5 && !arg6) {
            assert!(0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::above_premium(arg3, arg0.ref_sqrt, 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::config::min_ask_premium_bps(v0)), 419);
        };
        if (arg6) {
            assert!(!0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::token_heavy(arg0.t_value, arg0.q_value, 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::config::max_token_value_bps(v0)), 410);
        };
    }

    public(friend) fun close_retired<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut Book<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock) : 0x2::object::ID {
        assert!(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3) == arg1.pool_id, 400);
        assert!(arg4 < 0x1::vector::length<0x2::object::ID>(&arg1.retired), 412);
        let v0 = 0x1::vector::swap_remove<0x2::object::ID>(&mut arg1.retired, arg4);
        let v1 = RetiredKey{id: v0};
        let v2 = 0x2::dynamic_object_field::remove<RetiredKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, v1);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::is_empty(&v2), 421);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg5, arg2, arg3, v2);
        v0
    }

    public(friend) fun collect_range_fees<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &Book<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3) == arg1.pool_id, 400);
        assert!(arg4 < 0x1::vector::length<0x2::object::ID>(&arg1.ranges), 412);
        let v0 = RangeKey{id: *0x1::vector::borrow<0x2::object::ID>(&arg1.ranges, arg4)};
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg5, arg2, arg3, 0x2::dynamic_object_field::borrow_mut<RangeKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, v0));
        (v3, v4)
    }

    public(friend) fun composition<T0, T1>(arg0: &0x2::object::UID, arg1: &Book<T0, T1>, arg2: u128) : (u64, u64) {
        let (v0, v1) = amounts<T0, T1>(arg0, arg1, arg2);
        (0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::token_value(v0, arg2), v1)
    }

    public(friend) fun finish<T0, T1>(arg0: Ticket, arg1: &mut Book<T0, T1>) : Finished {
        let Ticket {
            owner    : _,
            ref_sqrt : v1,
            value    : v2,
            t_value  : _,
            q_value  : _,
            added    : v5,
            now      : v6,
        } = arg0;
        0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::add_turnover(&mut arg1.turnover, v6, v5);
        let v7 = 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::turnover(&arg1.turnover, v6);
        assert!(0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::turnover_ok(v7, v2, 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::config::max_turnover_bps(&arg1.limits)), 411);
        Finished{
            ref_sqrt     : v1,
            value        : v2,
            added        : v5,
            turnover_24h : v7,
            ranges       : 0x1::vector::length<0x2::object::ID>(&arg1.ranges),
            now          : v6,
        }
    }

    public(friend) fun finished_fields(arg0: &Finished) : (u128, u64, u64, u64, u64, u64) {
        (arg0.ref_sqrt, arg0.value, arg0.added, arg0.turnover_24h, arg0.ranges, arg0.now)
    }

    public(friend) fun holds<T0, T1>(arg0: &Book<T0, T1>, arg1: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.ranges, &arg1) || 0x1::vector::contains<0x2::object::ID>(&arg0.retired, &arg1)
    }

    public fun idle<T0, T1>(arg0: &Book<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.idle_t), 0x2::balance::value<T1>(&arg0.idle_q))
    }

    public(friend) fun join_q<T0, T1>(arg0: &mut Book<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.idle_q, arg1);
    }

    public(friend) fun join_t<T0, T1>(arg0: &mut Book<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.idle_t, arg1);
    }

    public(friend) fun ladder_shape() : (vector<u32>, u32, u64) {
        (vector[1800, 4000], 1000, 3333)
    }

    public fun last_rebalance_ms<T0, T1>(arg0: &Book<T0, T1>) : u64 {
        arg0.last_rebalance_ms
    }

    public fun limits<T0, T1>(arg0: &Book<T0, T1>) : 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::config::Limits {
        arg0.limits
    }

    public(friend) fun make_ticket(arg0: &0x2::object::UID, arg1: u128, arg2: u64, arg3: u64, arg4: u64) : Ticket {
        let v0 = 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::token_value(arg2, arg1);
        Ticket{
            owner    : 0x2::object::uid_to_inner(arg0),
            ref_sqrt : arg1,
            value    : v0 + arg3,
            t_value  : v0,
            q_value  : arg3,
            added    : 0,
            now      : arg4,
        }
    }

    public fun max_ranges() : u64 {
        8
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public(friend) fun new<T0, T1>(arg0: 0x2::object::ID, arg1: 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::config::Limits, arg2: u32, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>) : Book<T0, T1> {
        new_on<T0, T1>(0, false, arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun new_added(arg0: 0x2::object::ID, arg1: u32, arg2: u32, arg3: u64, arg4: u64) : Added {
        Added{
            position_id     : arg0,
            lower_tick_bits : arg1,
            upper_tick_bits : arg2,
            tokens          : arg3,
            quote           : arg4,
        }
    }

    public(friend) fun new_on<T0, T1>(arg0: u8, arg1: bool, arg2: 0x2::object::ID, arg3: 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::config::Limits, arg4: u32, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>) : Book<T0, T1> {
        assert!(arg0 == 0 || arg0 == 1, 424);
        assert!(arg0 == 1 || !arg1, 424);
        Book<T0, T1>{
            pool_id           : arg2,
            venue             : arg0,
            quote_first       : arg1,
            limits            : arg3,
            tick_spacing      : arg4,
            idle_t            : arg5,
            idle_q            : arg6,
            ranges            : 0x1::vector::empty<0x2::object::ID>(),
            retired           : 0x1::vector::empty<0x2::object::ID>(),
            observations      : 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::new_observations(),
            turnover          : 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::new_turnover(),
            last_rebalance_ms : 0,
            rebalance_paused  : false,
        }
    }

    public(friend) fun new_removed(arg0: 0x2::object::ID, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: bool) : Removed {
        Removed{
            position_id : arg0,
            liquidity   : arg1,
            tokens      : arg2,
            quote       : arg3,
            fee_t       : arg4,
            fee_q       : arg5,
            closed      : arg6,
            retired     : arg7,
        }
    }

    public fun observations<T0, T1>(arg0: &Book<T0, T1>) : &0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::Observations {
        &arg0.observations
    }

    public(friend) fun observe<T0, T1>(arg0: &mut Book<T0, T1>, arg1: u64, arg2: u128) : u128 {
        0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::observe(&mut arg0.observations, arg1, arg2)
    }

    public(friend) fun place_launch_ladder<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut Book<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : vector<Added> {
        assert_pool_id<T0, T1>(arg1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 0);
        0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::seed(&mut arg1.observations, 0x2::clock::timestamp_ms(arg4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3));
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg1.tick_spacing);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v0, v1);
        let v3 = v2;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(v2)) {
            v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v2, v1);
        };
        let v4 = vector[1800, 4000];
        let v5 = 0x1::vector::length<u32>(&v4);
        let v6 = mul_div(0x2::balance::value<T0>(&arg1.idle_t), 3333, 10000) / v5;
        let v7 = 0x1::vector::empty<Added>();
        let v8 = 0;
        while (v8 < v5) {
            let v9 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, v3), v1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(*0x1::vector::borrow<u32>(&v4, v8)));
            let v10 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v9, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1000));
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::is_valid_index(v9, arg1.tick_spacing) && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::is_valid_index(v10, arg1.tick_spacing)) {
                if (v6 > 0) {
                    let v11 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg2, arg3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v9), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v10), arg5);
                    let (v12, _, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg4, arg2, arg3, &mut v11, 0x2::balance::split<T0>(&mut arg1.idle_t, v6), 0x2::balance::zero<T1>(), v6, true);
                    0x2::balance::join<T0>(&mut arg1.idle_t, v14);
                    0x2::balance::destroy_zero<T1>(v15);
                    let v16 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v11);
                    let v17 = RangeKey{id: v16};
                    0x2::dynamic_object_field::add<RangeKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, v17, v11);
                    0x1::vector::push_back<0x2::object::ID>(&mut arg1.ranges, v16);
                    let v18 = Added{
                        position_id     : v16,
                        lower_tick_bits : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v9),
                        upper_tick_bits : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v10),
                        tokens          : v12,
                        quote           : 0,
                    };
                    0x1::vector::push_back<Added>(&mut v7, v18);
                };
            };
            v8 = v8 + 1;
        };
        v7
    }

    public fun pool_id<T0, T1>(arg0: &Book<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun pop_range<T0, T1, T2: store + key>(arg0: &mut 0x2::object::UID, arg1: &mut Book<T0, T1>, arg2: u64) : T2 {
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg1.ranges, arg2);
        let v0 = RangeKey{id: range_id<T0, T1>(arg1, arg2)};
        0x2::dynamic_object_field::remove<RangeKey, T2>(arg0, v0)
    }

    public(friend) fun pop_retired<T0, T1, T2: store + key>(arg0: &mut 0x2::object::UID, arg1: &mut Book<T0, T1>, arg2: u64) : T2 {
        assert!(arg2 < 0x1::vector::length<0x2::object::ID>(&arg1.retired), 412);
        let v0 = RetiredKey{id: 0x1::vector::swap_remove<0x2::object::ID>(&mut arg1.retired, arg2)};
        0x2::dynamic_object_field::remove<RetiredKey, T2>(arg0, v0)
    }

    public(friend) fun prepare_ticket<T0, T1>(arg0: &mut Book<T0, T1>, arg1: u64) : u128 {
        assert!(!arg0.rebalance_paused, 403);
        assert!(arg0.last_rebalance_ms == 0 || arg1 >= arg0.last_rebalance_ms + 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::config::min_interval_ms(&arg0.limits), 404);
        arg0.last_rebalance_ms = arg1;
        0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::reference(&arg0.observations, arg1)
    }

    public(friend) fun push_range<T0, T1, T2: store + key>(arg0: &mut 0x2::object::UID, arg1: &mut Book<T0, T1>, arg2: T2) : 0x2::object::ID {
        let v0 = 0x2::object::id<T2>(&arg2);
        let v1 = RangeKey{id: v0};
        0x2::dynamic_object_field::add<RangeKey, T2>(arg0, v1, arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.ranges, v0);
        v0
    }

    public fun quote_first<T0, T1>(arg0: &Book<T0, T1>) : bool {
        arg0.quote_first
    }

    public fun range_count<T0, T1>(arg0: &Book<T0, T1>) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.ranges)
    }

    public(friend) fun range_id<T0, T1>(arg0: &Book<T0, T1>, arg1: u64) : 0x2::object::ID {
        assert!(arg1 < 0x1::vector::length<0x2::object::ID>(&arg0.ranges), 412);
        *0x1::vector::borrow<0x2::object::ID>(&arg0.ranges, arg1)
    }

    public(friend) fun range_index<T0, T1>(arg0: &Book<T0, T1>, arg1: 0x2::object::ID) : u64 {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.ranges, &arg1);
        assert!(v0, 412);
        v1
    }

    public(friend) fun range_liquidity<T0, T1>(arg0: &0x2::object::UID, arg1: &Book<T0, T1>, arg2: u64) : u128 {
        assert!(arg2 < 0x1::vector::length<0x2::object::ID>(&arg1.ranges), 412);
        let v0 = RangeKey{id: *0x1::vector::borrow<0x2::object::ID>(&arg1.ranges, arg2)};
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x2::dynamic_object_field::borrow<RangeKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, v0))
    }

    public fun ranges<T0, T1>(arg0: &Book<T0, T1>) : vector<0x2::object::ID> {
        arg0.ranges
    }

    public fun rebalance_paused<T0, T1>(arg0: &Book<T0, T1>) : bool {
        arg0.rebalance_paused
    }

    public(friend) fun reclaim_crossed<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut Book<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock) : (Removed, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3) == arg1.pool_id, 400);
        assert!(arg4 < 0x1::vector::length<0x2::object::ID>(&arg1.ranges), 412);
        let v0 = RangeKey{id: *0x1::vector::borrow<0x2::object::ID>(&arg1.ranges, arg4)};
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(0x2::dynamic_object_field::borrow<RangeKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, v0))), 423);
        take_range<T0, T1>(arg0, arg1, arg2, arg3, arg4, 340282366920938463463374607431768211455, arg5)
    }

    public(friend) fun record_add<T0, T1, T2: store + key>(arg0: &mut Ticket, arg1: &mut 0x2::object::UID, arg2: &mut Book<T0, T1>, arg3: T2, arg4: u32, arg5: u32, arg6: u64, arg7: u64, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T1>, arg10: bool, arg11: u64) : Added {
        let v0 = if (arg10) {
            arg7
        } else {
            arg6
        };
        assert!(v0 <= arg11, 420);
        0x2::balance::join<T0>(&mut arg2.idle_t, arg8);
        0x2::balance::join<T1>(&mut arg2.idle_q, arg9);
        arg0.added = arg0.added + arg7;
        Added{
            position_id     : push_range<T0, T1, T2>(arg1, arg2, arg3),
            lower_tick_bits : arg4,
            upper_tick_bits : arg5,
            tokens          : arg6,
            quote           : arg7,
        }
    }

    public(friend) fun reference<T0, T1>(arg0: &Book<T0, T1>, arg1: u64) : u128 {
        0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::reference(&arg0.observations, arg1)
    }

    public(friend) fun removed_fields(arg0: &Removed) : (0x2::object::ID, u128, u64, u64, u64, u64, bool, bool) {
        (arg0.position_id, arg0.liquidity, arg0.tokens, arg0.quote, arg0.fee_t, arg0.fee_q, arg0.closed, arg0.retired)
    }

    public(friend) fun retire<T0, T1, T2: store + key>(arg0: &mut 0x2::object::UID, arg1: &mut Book<T0, T1>, arg2: T2) {
        let v0 = 0x2::object::id<T2>(&arg2);
        let v1 = RetiredKey{id: v0};
        0x2::dynamic_object_field::add<RetiredKey, T2>(arg0, v1, arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.retired, v0);
    }

    public fun retired<T0, T1>(arg0: &Book<T0, T1>) : vector<0x2::object::ID> {
        arg0.retired
    }

    public(friend) fun retired_index<T0, T1>(arg0: &Book<T0, T1>, arg1: 0x2::object::ID) : u64 {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.retired, &arg1);
        assert!(v0, 412);
        v1
    }

    public(friend) fun seed<T0, T1>(arg0: &mut Book<T0, T1>, arg1: u64, arg2: u128) {
        0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::seed(&mut arg0.observations, arg1, arg2);
    }

    public(friend) fun set_rebalance_paused<T0, T1>(arg0: &mut Book<T0, T1>, arg1: bool) {
        arg0.rebalance_paused = arg1;
    }

    public(friend) fun split_q<T0, T1>(arg0: &mut Book<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(&mut arg0.idle_q, arg1)
    }

    public(friend) fun split_t<T0, T1>(arg0: &mut Book<T0, T1>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.idle_t, arg1)
    }

    public(friend) fun take_for_add<T0, T1>(arg0: &mut Book<T0, T1>, arg1: bool, arg2: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = if (arg1) {
            0x2::balance::withdraw_all<T0>(&mut arg0.idle_t)
        } else {
            0x2::balance::zero<T0>()
        };
        let v1 = if (arg2) {
            0x2::balance::withdraw_all<T1>(&mut arg0.idle_q)
        } else {
            0x2::balance::zero<T1>()
        };
        (v0, v1)
    }

    public(friend) fun take_range<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut Book<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock) : (Removed, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert_pool_id<T0, T1>(arg1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 0);
        assert!(arg4 < 0x1::vector::length<0x2::object::ID>(&arg1.ranges), 412);
        let v0 = *0x1::vector::borrow<0x2::object::ID>(&arg1.ranges, arg4);
        let v1 = RangeKey{id: v0};
        let v2 = 0x2::dynamic_object_field::borrow_mut<RangeKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, v1);
        let (v3, v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg6, arg2, arg3, v2);
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v2);
        let v8 = if (arg5 > v7) {
            v7
        } else {
            arg5
        };
        let (v9, v10, v11, v12) = if (v8 > 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg2, arg3, v2, v8, arg6)
        } else {
            (0, 0, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v13 = v8 == v7;
        let v14 = false;
        if (v13) {
            let v15 = RangeKey{id: v0};
            0x1::vector::swap_remove<0x2::object::ID>(&mut arg1.ranges, arg4);
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::is_empty(v2)) {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg6, arg2, arg3, 0x2::dynamic_object_field::remove<RangeKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, v15));
            } else {
                let v16 = RetiredKey{id: v0};
                0x2::dynamic_object_field::add<RetiredKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, v16, 0x2::dynamic_object_field::remove<RangeKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, v15));
                0x1::vector::push_back<0x2::object::ID>(&mut arg1.retired, v0);
                v14 = true;
            };
        };
        let v17 = Removed{
            position_id : v0,
            liquidity   : v8,
            tokens      : v9,
            quote       : v10,
            fee_t       : v3,
            fee_q       : v4,
            closed      : v13,
            retired     : v14,
        };
        (v17, v11, v12, v5, v6)
    }

    public fun tick_spacing<T0, T1>(arg0: &Book<T0, T1>) : u32 {
        arg0.tick_spacing
    }

    public fun turnover_24h<T0, T1>(arg0: &Book<T0, T1>, arg1: u64) : u64 {
        0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits::turnover(&arg0.turnover, arg1)
    }

    public fun venue<T0, T1>(arg0: &Book<T0, T1>) : u8 {
        arg0.venue
    }

    // decompiled from Move bytecode v7
}

