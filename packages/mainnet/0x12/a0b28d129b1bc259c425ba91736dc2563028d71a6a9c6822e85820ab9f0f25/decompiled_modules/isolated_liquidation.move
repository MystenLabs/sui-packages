module 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::isolated_liquidation {
    struct TradeExecuted has copy, drop {
        sender: address,
        perpID: 0x2::object::ID,
        tradeType: u8,
        maker: address,
        taker: address,
        makerMRO: u128,
        takerMRO: u128,
        makerPnl: 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::Number,
        takerPnl: 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::Number,
        tradeQuantity: u128,
        tradePrice: u128,
        isBuy: bool,
    }

    struct TradeData has copy, drop {
        liquidator: address,
        liquidatee: address,
        quantity: u128,
        leverage: u128,
        allOrNothing: bool,
    }

    struct IMResponse has drop {
        fundsFlow: 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::Number,
        pnl: 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::Number,
    }

    struct Premium has copy, drop, store {
        pool: 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::Number,
        liquidator: 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::Number,
    }

    struct TradeResponse has copy, drop, store {
        makerFundsFlow: 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::Number,
        takerFundsFlow: 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::Number,
        premium: Premium,
    }

    fun apply_isolated_margin(arg0: &mut 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::UserPosition, arg1: 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::evaluator::TradeChecks, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: bool, arg7: u64) : IMResponse {
        let v0 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::qPos(*arg0);
        let v1 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::isPosPositive(*arg0);
        let v2 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::margin(*arg0);
        let v3 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::compute_pnl_per_unit(*arg0, arg3);
        let v4 = v3;
        let v5 = if (v0 == 0 || arg6 == v1) {
            let v6 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::library::base_mul(arg3, arg5);
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::set_oiOpen(arg0, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::oiOpen(*arg0) + 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::library::base_mul(arg2, arg3));
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::set_qPos(arg0, v0 + arg2);
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::set_margin(arg0, v2 + 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::library::base_mul(arg2, v6));
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::set_isPosPositive(arg0, arg6);
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::evaluator::verify_oi_open_for_account(arg1, arg5, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::oiOpen(*arg0), arg7);
            v4 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::new();
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::from(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::library::base_mul(arg2, v6), true)
        } else if (arg6 != v1 && arg2 <= v0) {
            let v7 = v0 - arg2;
            let v5 = if (arg7 == 1) {
                assert!(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::gte_uint(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::add_uint(v3, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::library::base_div(v2, v0)), 0), 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::error::loss_exceeds_margin(arg7));
                0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::negative_number(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::sub_uint(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::mul_uint(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::negate(v3), arg2), v2 * arg2 / v0))
            } else {
                v4 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::compute_pnl_per_unit(*arg0, arg4);
                0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::new()
            };
            v4 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::mul_uint(v4, arg2);
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::set_margin(arg0, v2 * v7 / v0);
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::set_oiOpen(arg0, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::oiOpen(*arg0) * v7 / v0);
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::set_qPos(arg0, v7);
            v5
        } else {
            let v8 = arg2 - v0;
            let v9 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::library::base_mul(v8, arg3);
            let v10 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::library::base_mul(v9, arg5);
            assert!(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::gte_uint(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::add_uint(v3, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::library::base_div(v2, v0)), 0), 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::error::loss_exceeds_margin(arg7));
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::evaluator::verify_oi_open_for_account(arg1, arg5, v9, arg7);
            v4 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::mul_uint(v3, v0);
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::set_qPos(arg0, v8);
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::set_oiOpen(arg0, v9);
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::set_margin(arg0, v10);
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::set_isPosPositive(arg0, !v1);
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::add_uint(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::sub_uint(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::mul_uint(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::negate(v3), v0), v2), v10)
        };
        0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::set_mro(arg0, arg5);
        IMResponse{
            fundsFlow : v5,
            pnl       : v4,
        }
    }

    fun calculate_premium(arg0: bool, arg1: u128, arg2: u128, arg3: u128, arg4: u128) : Premium {
        let v0 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::new();
        let (v1, v2) = if (arg0) {
            (arg2 >= arg3, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::from_subtraction(arg2, arg3))
        } else {
            (arg2 <= arg3, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::from_subtraction(arg3, arg2))
        };
        let v3 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::mul_uint(v2, arg1);
        let v4 = if (v1 == true) {
            v0 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::mul_uint(v3, arg4);
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::mul_uint(v3, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::library::base_uint() - arg4)
        } else {
            v3
        };
        Premium{
            pool       : v0,
            liquidator : v4,
        }
    }

    public(friend) fun insurancePoolPortion(arg0: TradeResponse) : 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::Number {
        arg0.premium.pool
    }

    public(friend) fun liquidatorPortion(arg0: TradeResponse) : 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::Number {
        arg0.premium.liquidator
    }

    public(friend) fun makerFundsFlow(arg0: TradeResponse) : 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::Number {
        arg0.makerFundsFlow
    }

    public(friend) fun pack_trade_data(arg0: address, arg1: address, arg2: u128, arg3: u128, arg4: bool) : TradeData {
        TradeData{
            liquidator   : arg0,
            liquidatee   : arg1,
            quantity     : arg2,
            leverage     : arg3,
            allOrNothing : arg4,
        }
    }

    public(friend) fun takerFundsFlow(arg0: TradeResponse) : 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::Number {
        arg0.takerFundsFlow
    }

    public(friend) fun trade(arg0: address, arg1: &mut 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::perpetual::Perpetual, arg2: TradeData) : TradeResponse {
        let v0 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::perpetual::imr(arg1);
        let v1 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::perpetual::mmr(arg1);
        let v2 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::perpetual::checks(arg1);
        let v3 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::perpetual::positions(arg1);
        let v4 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::library::round(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::perpetual::priceOracle(arg1), 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::evaluator::tickSize(v2));
        0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::evaluator::verify_min_max_price(v2, v4);
        0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::evaluator::verify_qty_checks(v2, arg2.quantity);
        let v5 = *0x2::table::borrow<address, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::UserPosition>(v3, arg2.liquidatee);
        let v6 = *0x2::table::borrow<address, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::UserPosition>(v3, arg2.liquidator);
        let v7 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::isPosPositive(v5);
        verify_trade(arg2, v5, v6, v4, v1);
        let v8 = if (0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::isPosPositive(v5)) {
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::library::base_div(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::oiOpen(v5) - 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::margin(v5), 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::qPos(v5))
        } else {
            0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::library::base_div(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::oiOpen(v5) + 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::margin(v5), 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::qPos(v5))
        };
        let v9 = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::library::min(arg2.quantity, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::qPos(v5));
        let v10 = 0x2::table::borrow_mut<address, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::UserPosition>(v3, arg2.liquidatee);
        let v11 = apply_isolated_margin(v10, v2, v9, v4, v8, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::mro(v5), !0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::isPosPositive(v5), 0);
        let v12 = 0x2::table::borrow_mut<address, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::UserPosition>(v3, arg2.liquidator);
        let v13 = apply_isolated_margin(v12, v2, v9, v4, v8, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::library::compute_mro(arg2.leverage), 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::isPosPositive(v5), 1);
        let v14 = *0x2::table::borrow<address, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::UserPosition>(v3, arg2.liquidatee);
        let v15 = *0x2::table::borrow<address, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::UserPosition>(v3, arg2.liquidator);
        0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::verify_collat_checks(v5, v14, v0, v1, v4, 2, 0);
        0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::verify_collat_checks(v6, v15, v0, v1, v4, 2, 1);
        let v16 = calculate_premium(v7, v9, v4, v8, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::perpetual::poolPercentage(arg1));
        v13.pnl = 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::signed_number::add(v16.liquidator, v13.pnl);
        0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::emit_position_update_event(v14, arg0, 0);
        0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::emit_position_update_event(v15, arg0, 0);
        let v17 = TradeExecuted{
            sender        : arg0,
            perpID        : 0x2::object::uid_to_inner(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::perpetual::id(arg1)),
            tradeType     : 2,
            maker         : arg2.liquidatee,
            taker         : arg2.liquidator,
            makerMRO      : 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::mro(v14),
            takerMRO      : 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::mro(v15),
            makerPnl      : v11.pnl,
            takerPnl      : v13.pnl,
            tradeQuantity : arg2.quantity,
            tradePrice    : v4,
            isBuy         : v7,
        };
        0x2::event::emit<TradeExecuted>(v17);
        TradeResponse{
            makerFundsFlow : v11.fundsFlow,
            takerFundsFlow : v13.fundsFlow,
            premium        : v16,
        }
    }

    public(friend) fun tradeType() : u8 {
        2
    }

    fun verify_trade(arg0: TradeData, arg1: 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::UserPosition, arg2: 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::UserPosition, arg3: u128, arg4: u128) {
        assert!(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::qPos(arg1) > 0, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::error::user_position_size_is_zero(0));
        assert!(!arg0.allOrNothing || 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::qPos(arg1) >= arg0.quantity, 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::error::liquidation_all_or_nothing_constraint_not_held());
        assert!(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::is_undercollat(arg1, arg3, arg4), 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::error::liquidatee_above_mmr());
        assert!(0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::mro(arg2) == 0 || 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::library::compute_mro(arg0.leverage) == 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::position::mro(arg2), 0x12a0b28d129b1bc259c425ba91736dc2563028d71a6a9c6822e85820ab9f0f25::error::invalid_liquidator_leverage());
    }

    // decompiled from Move bytecode v6
}

