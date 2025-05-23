module 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::isolated_adl {
    struct TradeExecuted has copy, drop {
        sender: address,
        perpID: 0x2::object::ID,
        tradeType: u8,
        maker: address,
        taker: address,
        makerMRO: u128,
        takerMRO: u128,
        makerPnl: 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::Number,
        takerPnl: 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::Number,
        tradeQuantity: u128,
        tradePrice: u128,
        isBuy: bool,
    }

    struct TradeData has copy, drop {
        maker: address,
        taker: address,
        quantity: u128,
        allOrNothing: bool,
    }

    struct IMResponse has drop {
        fundsFlow: 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::Number,
        pnl: 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::Number,
    }

    struct TradeResponse has copy, drop {
        makerFundsFlow: 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::Number,
        takerFundsFlow: 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::Number,
    }

    fun apply_isolated_margin(arg0: &mut 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::UserPosition, arg1: u128, arg2: u128, arg3: u64) : IMResponse {
        let v0 = 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::qPos(*arg0);
        let v1 = 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::margin(*arg0);
        let v2 = 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::compute_pnl_per_unit(*arg0, arg2);
        let v3 = v0 - arg1;
        assert!(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::gte_uint(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::add_uint(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::add(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::from(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::base_div(v1, v0), true), v2), 100000), 0), 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::error::loss_exceeds_margin(arg3));
        0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::set_margin(arg0, v1 * v3 / v0);
        0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::set_oiOpen(arg0, 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::oiOpen(*arg0) * v3 / v0);
        0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::set_qPos(arg0, v3);
        IMResponse{
            fundsFlow : 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::negative_number(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::sub_uint(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::mul_uint(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::negate(v2), arg1), v1 * arg1 / v0)),
            pnl       : 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::mul_uint(v2, arg1),
        }
    }

    public(friend) fun makerFundsFlow(arg0: TradeResponse) : 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::Number {
        arg0.makerFundsFlow
    }

    public(friend) fun pack_trade_data(arg0: address, arg1: address, arg2: u128, arg3: bool) : TradeData {
        TradeData{
            maker        : arg0,
            taker        : arg1,
            quantity     : arg2,
            allOrNothing : arg3,
        }
    }

    public(friend) fun takerFundsFlow(arg0: TradeResponse) : 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::Number {
        arg0.takerFundsFlow
    }

    public(friend) fun trade(arg0: address, arg1: &mut 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::perpetual::Perpetual, arg2: TradeData) : TradeResponse {
        let v0 = 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::perpetual::imr(arg1);
        let v1 = 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::perpetual::mmr(arg1);
        let v2 = 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::perpetual::checks(arg1);
        let v3 = 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::perpetual::positions(arg1);
        let v4 = 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::round(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::perpetual::priceOracle(arg1), 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::evaluator::tickSize(v2));
        0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::evaluator::verify_min_max_price(v2, v4);
        0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::evaluator::verify_qty_checks(v2, arg2.quantity);
        let v5 = *0x2::table::borrow<address, 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::UserPosition>(v3, arg2.maker);
        let v6 = *0x2::table::borrow<address, 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::UserPosition>(v3, arg2.taker);
        verify_trade(v5, v6, arg2, v4);
        let v7 = if (0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::isPosPositive(v5)) {
            0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::base_div(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::oiOpen(v5) - 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::margin(v5), 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::qPos(v5))
        } else {
            0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::base_div(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::oiOpen(v5) + 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::margin(v5), 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::qPos(v5))
        };
        let v8 = 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::min(arg2.quantity, 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::min(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::qPos(v5), 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::qPos(v6)));
        let v9 = 0x2::table::borrow_mut<address, 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::UserPosition>(v3, arg2.maker);
        let v10 = apply_isolated_margin(v9, v8, v7, 0);
        let v11 = 0x2::table::borrow_mut<address, 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::UserPosition>(v3, arg2.taker);
        let v12 = apply_isolated_margin(v11, v8, v7, 1);
        let v13 = *0x2::table::borrow<address, 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::UserPosition>(v3, arg2.maker);
        let v14 = *0x2::table::borrow<address, 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::UserPosition>(v3, arg2.taker);
        0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::verify_collat_checks(v5, v13, v0, v1, v4, 3, 0);
        0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::verify_collat_checks(v6, v14, v0, v1, v4, 3, 1);
        0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::emit_position_update_event(v13, arg0, 0);
        0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::emit_position_update_event(v14, arg0, 0);
        let v15 = TradeExecuted{
            sender        : arg0,
            perpID        : 0x2::object::uid_to_inner(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::perpetual::id(arg1)),
            tradeType     : 3,
            maker         : arg2.maker,
            taker         : arg2.taker,
            makerMRO      : 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::mro(v13),
            takerMRO      : 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::mro(v14),
            makerPnl      : v10.pnl,
            takerPnl      : v12.pnl,
            tradeQuantity : arg2.quantity,
            tradePrice    : v7,
            isBuy         : 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::isPosPositive(v5),
        };
        0x2::event::emit<TradeExecuted>(v15);
        TradeResponse{
            makerFundsFlow : v10.fundsFlow,
            takerFundsFlow : v12.fundsFlow,
        }
    }

    public(friend) fun tradeType() : u8 {
        3
    }

    fun verify_account(arg0: 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::UserPosition, arg1: TradeData, arg2: u64) {
        assert!(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::qPos(arg0) > 0, 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::error::user_position_size_is_zero(arg2));
        assert!(!arg1.allOrNothing || 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::qPos(arg0) >= arg1.quantity, 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::error::adl_all_or_nothing_constraint_can_not_be_held(arg2));
    }

    fun verify_trade(arg0: 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::UserPosition, arg1: 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::UserPosition, arg2: TradeData, arg3: u128) {
        verify_account(arg0, arg2, 0);
        verify_account(arg1, arg2, 1);
        assert!(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::lte_uint(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::compute_margin_ratio(arg0, arg3), 0), 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::error::maker_is_not_underwater());
        assert!(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::gt_uint(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::compute_margin_ratio(arg1, arg3), 0), 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::error::taker_is_under_underwater());
        assert!(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::isPosPositive(arg0) != 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::isPosPositive(arg1), 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::error::maker_taker_must_have_opposite_side_positions());
    }

    // decompiled from Move bytecode v6
}

