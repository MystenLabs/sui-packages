module 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::isolated_liquidation {
    struct TradeExecutedEvent has copy, drop {
        tx_index: u128,
        sender: address,
        perp_id: 0x2::object::ID,
        trade_type: u8,
        maker: address,
        taker: address,
        maker_mro: u128,
        taker_mro: u128,
        maker_pnl: 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::S128,
        taker_pnl: 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::S128,
        trade_quantity: u128,
        trade_price: u128,
        is_long: bool,
    }

    struct TradeData has copy, drop {
        liquidator: address,
        liquidatee: address,
        quantity: u128,
        all_or_nothing: bool,
    }

    struct IMResponse has drop {
        funds_flow: 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::S128,
        pnl: 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::S128,
    }

    struct TradeResponse has copy, drop, store {
        maker_funds_flow: 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::S128,
        taker_funds_flow: 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::S128,
        premium: 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::S128,
    }

    fun apply_isolated_margin(arg0: &mut 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::Position, arg1: 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::evaluator::TradeChecks, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: bool, arg7: u64, arg8: bool) : IMResponse {
        let v0 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::size(arg0);
        let v1 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::is_long(arg0);
        let v2 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::margin(arg0);
        let v3 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::compute_pnl_per_unit(arg0, arg3);
        let v4 = v3;
        let v5 = if (v0 == 0 || arg6 == v1) {
            let v6 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_mul(arg3, arg5);
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::set_oi_open(arg0, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::oi_open(arg0) + 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_mul(arg2, arg3));
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::set_size(arg0, v0 + arg2);
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::set_margin(arg0, v2 + 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_mul(arg2, v6));
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::set_is_long(arg0, arg6);
            if (arg7 == 0) {
                0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::evaluator::verify_oi_open_for_account(arg1, arg5, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::oi_open(arg0), arg7, arg8);
            };
            v4 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::zero();
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::from(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_mul(arg2, v6), true)
        } else if (arg6 != v1 && arg2 <= v0) {
            let v7 = v0 - arg2;
            let v5 = if (arg7 == 1) {
                assert!(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::gte_u128(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::add_u128(v3, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_div(v2, v0)), 0), 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::error::loss_exceeds_margin(arg7));
                0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::negative_number(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::sub_u128(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::mul_u128(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::negate(v3), arg2), v2 * arg2 / v0))
            } else {
                v4 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::compute_pnl_per_unit(arg0, arg4);
                0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::zero()
            };
            v4 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::mul_u128(v4, arg2);
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::set_margin(arg0, v2 * v7 / v0);
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::set_oi_open(arg0, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::oi_open(arg0) * v7 / v0);
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::set_size(arg0, v7);
            v5
        } else {
            let v8 = arg2 - v0;
            let v9 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_mul(v8, arg3);
            let v10 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_mul(v9, arg5);
            assert!(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::gte_u128(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::add_u128(v3, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_div(v2, v0)), 0), 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::error::loss_exceeds_margin(arg7));
            if (arg7 == 0) {
                0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::evaluator::verify_oi_open_for_account(arg1, arg5, v9, arg7, arg8);
            };
            v4 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::mul_u128(v3, v0);
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::set_size(arg0, v8);
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::set_oi_open(arg0, v9);
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::set_margin(arg0, v10);
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::set_is_long(arg0, !v1);
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::add_u128(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::sub_u128(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::mul_u128(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::negate(v3), v0), v2), v10)
        };
        0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::set_mro(arg0, arg5);
        IMResponse{
            funds_flow : v5,
            pnl        : v4,
        }
    }

    fun calculate_premium(arg0: bool, arg1: u128, arg2: u128, arg3: u128) : 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::S128 {
        let v0 = if (arg0) {
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::from_subtraction(arg2, arg3)
        } else {
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::from_subtraction(arg3, arg2)
        };
        0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::mul_u128(v0, arg1)
    }

    public(friend) fun maker_funds_flow(arg0: TradeResponse) : 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::S128 {
        arg0.maker_funds_flow
    }

    public(friend) fun pack_trade_data(arg0: address, arg1: address, arg2: u128, arg3: bool) : TradeData {
        TradeData{
            liquidator     : arg0,
            liquidatee     : arg1,
            quantity       : arg2,
            all_or_nothing : arg3,
        }
    }

    public(friend) fun premium(arg0: TradeResponse) : 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::S128 {
        arg0.premium
    }

    public(friend) fun taker_funds_flow(arg0: TradeResponse) : 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::S128 {
        arg0.taker_funds_flow
    }

    public(friend) fun trade(arg0: &0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::protocol::ProtocolConfig, arg1: address, arg2: &mut 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::perpetual::Perpetual, arg3: TradeData, arg4: u128) : TradeResponse {
        let v0 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::perpetual::mmr(arg2);
        let v1 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::perpetual::checks(arg2);
        let v2 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::perpetual::positions(arg2);
        let v3 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::round(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::perpetual::price_oracle(arg2), 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::evaluator::tick_size(v1));
        0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::evaluator::verify_min_max_price(v1, v3);
        0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::evaluator::verify_qty_checks_liquidation(v1, arg3.quantity);
        let v4 = *0x2::table::borrow<address, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::Position>(v2, arg3.liquidatee);
        let v5 = *0x2::table::borrow<address, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::Position>(v2, arg3.liquidator);
        let v6 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::is_long(&v4);
        verify_trade(arg3, &v4, &v5, v3, v0);
        let v7 = if (0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::is_long(&v4)) {
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_div(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::oi_open(&v4) - 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::margin(&v4), 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::size(&v4))
        } else {
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_div(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::oi_open(&v4) + 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::margin(&v4), 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::size(&v4))
        };
        let v8 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::min(arg3.quantity, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::size(&v4));
        let v9 = 0x2::table::borrow_mut<address, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::Position>(v2, arg3.liquidatee);
        let v10 = apply_isolated_margin(v9, v1, v8, v3, v7, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::mro(&v4), !0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::is_long(&v4), 0, 0x2::vec_set::contains<address>(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::protocol::privileged_addresses(arg0), &arg3.liquidatee));
        let v11 = 0x2::table::borrow_mut<address, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::Position>(v2, arg3.liquidator);
        let v12 = apply_isolated_margin(v11, v1, v8, v3, v7, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::mro(&v5), 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::is_long(&v4), 1, 0x2::vec_set::contains<address>(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::protocol::privileged_addresses(arg0), &arg3.liquidator));
        let v13 = *0x2::table::borrow<address, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::Position>(v2, arg3.liquidatee);
        let v14 = *0x2::table::borrow<address, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::Position>(v2, arg3.liquidator);
        0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::verify_collat_checks(&v4, &v13, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::perpetual::imr(arg2), v0, v3, 2, 0);
        let v15 = calculate_premium(v6, v8, v3, v7);
        v12.pnl = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::add(v15, v12.pnl);
        0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::emit_position_update_event(v13, arg1, 0, arg4);
        0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::emit_position_update_event(v14, arg1, 0, arg4);
        let v16 = TradeExecutedEvent{
            tx_index       : arg4,
            sender         : arg1,
            perp_id        : 0x2::object::uid_to_inner(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::perpetual::id(arg2)),
            trade_type     : 2,
            maker          : arg3.liquidatee,
            taker          : arg3.liquidator,
            maker_mro      : 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::mro(&v13),
            taker_mro      : 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::mro(&v14),
            maker_pnl      : v10.pnl,
            taker_pnl      : v12.pnl,
            trade_quantity : arg3.quantity,
            trade_price    : v3,
            is_long        : v6,
        };
        0x2::event::emit<TradeExecutedEvent>(v16);
        TradeResponse{
            maker_funds_flow : v10.funds_flow,
            taker_funds_flow : v12.funds_flow,
            premium          : v15,
        }
    }

    public(friend) fun trade_type() : u8 {
        2
    }

    fun verify_trade(arg0: TradeData, arg1: &0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::Position, arg2: &0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::Position, arg3: u128, arg4: u128) {
        assert!(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::size(arg1) > 0, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::error::user_position_size_is_zero(0));
        assert!(!arg0.all_or_nothing || 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::size(arg1) >= arg0.quantity, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::error::liquidation_all_or_nothing_constraint_not_held());
        assert!(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::is_undercollat(arg1, arg3, arg4), 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::error::liquidatee_above_mmr());
        assert!(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::mro(arg2) == 0, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::error::invalid_liquidator_leverage());
    }

    // decompiled from Move bytecode v6
}

