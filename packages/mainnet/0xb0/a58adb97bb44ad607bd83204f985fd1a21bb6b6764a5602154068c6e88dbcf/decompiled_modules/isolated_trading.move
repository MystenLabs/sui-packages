module 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::isolated_trading {
    struct TradeExecuted has copy, drop {
        sender: address,
        perpID: 0x2::object::ID,
        tradeType: u8,
        maker: address,
        taker: address,
        makerOrderHash: vector<u8>,
        takerOrderHash: vector<u8>,
        makerMRO: u128,
        takerMRO: u128,
        makerFee: u128,
        takerFee: u128,
        makerPnl: 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::Number,
        takerPnl: 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::Number,
        tradeQuantity: u128,
        tradePrice: u128,
        isBuy: bool,
    }

    struct TradeData has copy, drop {
        makerSignature: vector<u8>,
        takerSignature: vector<u8>,
        makerPublicKey: vector<u8>,
        takerPublicKey: vector<u8>,
        makerOrder: 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::Order,
        takerOrder: 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::Order,
        fill: Fill,
        currentTime: u64,
    }

    struct Fill has copy, drop {
        quantity: u128,
        price: u128,
    }

    struct IMResponse has drop {
        fundsFlow: 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::Number,
        pnl: 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::Number,
        fee: u128,
    }

    struct TradeResponse has copy, drop, store {
        makerFundsFlow: 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::Number,
        takerFundsFlow: 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::Number,
        fee: u128,
    }

    fun apply_isolated_margin(arg0: 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::evaluator::TradeChecks, arg1: &mut 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::UserPosition, arg2: 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::Order, arg3: Fill, arg4: u128, arg5: u64) : IMResponse {
        let v0 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::isBuy(arg2);
        let v1 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::qPos(*arg1);
        let v2 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::isPosPositive(*arg1);
        let v3 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::margin(*arg1);
        let v4 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::compute_mro(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::leverage(arg2));
        let v5 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::compute_pnl_per_unit(*arg1, arg3.price);
        let (v6, v7) = if (v1 == 0 || v0 == v2) {
            let v8 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(arg3.price, v4);
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::set_oiOpen(arg1, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::oiOpen(*arg1) + 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(arg3.quantity, arg3.price));
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::set_qPos(arg1, v1 + arg3.quantity);
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::set_margin(arg1, v3 + 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(arg3.quantity, v8));
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::set_isPosPositive(arg1, v0);
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::evaluator::verify_oi_open_for_account(arg0, v4, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::oiOpen(*arg1), arg5);
            (0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::from(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(arg3.quantity, v8 + arg4), true), 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::new())
        } else if (0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::reduceOnly(arg2) || v0 != v2 && arg3.quantity <= v1) {
            let v9 = v1 - arg3.quantity;
            let v10 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::add_uint(v5, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_div(v3, v1));
            assert!(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::gte_uint(v10, 0), 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::error::loss_exceeds_margin(arg5));
            let v11 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::positive_value(v10);
            let v12 = if (arg4 > v11) {
                v11
            } else {
                arg4
            };
            arg4 = v12;
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::set_margin(arg1, v3 * v9 / v1);
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::set_oiOpen(arg1, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::oiOpen(*arg1) * v9 / v1);
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::set_qPos(arg1, v9);
            (0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::negative_number(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::sub_uint(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::mul_uint(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::add_uint(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::negate(v5), v11), arg3.quantity), v3 * arg3.quantity / v1)), 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::mul_uint(v5, arg3.quantity))
        } else {
            let v13 = arg3.quantity - v1;
            let v14 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(v13, arg3.price);
            let v15 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::add_uint(v5, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_div(v3, v1));
            assert!(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::gte_uint(v15, 0), 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::error::loss_exceeds_margin(arg5));
            let v16 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::positive_value(v15);
            let v17 = if (arg4 > v16) {
                v16
            } else {
                arg4
            };
            let v6 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::add_uint(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::sub_uint(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::mul_uint(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::add_uint(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::negate(v5), v17), v1), v3), 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(v13, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(arg3.price, v4) + arg4));
            let v18 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(v1, v17) + 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(v13, arg4);
            arg4 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_div(v18, arg3.quantity);
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::evaluator::verify_oi_open_for_account(arg0, v4, v14, arg5);
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::set_qPos(arg1, v13);
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::set_oiOpen(arg1, v14);
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::set_margin(arg1, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(v13, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(arg3.price, v4)));
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::set_isPosPositive(arg1, !v2);
            (v6, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::mul_uint(v5, v1))
        };
        0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::set_mro(arg1, v4);
        IMResponse{
            fundsFlow : v6,
            pnl       : v7,
            fee       : 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(arg4, arg3.quantity),
        }
    }

    public(friend) fun fee(arg0: TradeResponse) : u128 {
        arg0.fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x2::table::Table<vector<u8>, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::OrderStatus>>(0x2::table::new<vector<u8>, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::OrderStatus>(arg0));
    }

    public(friend) fun makerFundsFlow(arg0: TradeResponse) : 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::Number {
        arg0.makerFundsFlow
    }

    public(friend) fun pack_trade_data(arg0: u8, arg1: u128, arg2: u128, arg3: u128, arg4: address, arg5: u64, arg6: u128, arg7: vector<u8>, arg8: vector<u8>, arg9: u8, arg10: u128, arg11: u128, arg12: u128, arg13: address, arg14: u64, arg15: u128, arg16: vector<u8>, arg17: vector<u8>, arg18: u128, arg19: u128, arg20: address, arg21: u64) : TradeData {
        let v0 = Fill{
            quantity : arg18,
            price    : arg19,
        };
        TradeData{
            makerSignature : arg7,
            takerSignature : arg16,
            makerPublicKey : arg8,
            takerPublicKey : arg17,
            makerOrder     : 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::pack_order(arg20, arg0, arg1, arg2, arg3, arg4, arg5, arg6),
            takerOrder     : 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::pack_order(arg20, arg9, arg10, arg11, arg12, arg13, arg14, arg15),
            fill           : v0,
            currentTime    : arg21,
        }
    }

    public(friend) fun takerFundsFlow(arg0: TradeResponse) : 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::Number {
        arg0.takerFundsFlow
    }

    public(friend) fun trade(arg0: address, arg1: &mut 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::perpetual::Perpetual, arg2: &mut 0x2::table::Table<vector<u8>, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::OrderStatus>, arg3: &0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::roles::SubAccounts, arg4: TradeData) : TradeResponse {
        arg4.fill.quantity = arg4.fill.quantity / 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_uint();
        arg4.fill.price = arg4.fill.price / 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_uint();
        arg4.makerOrder = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::to_1x9(arg4.makerOrder);
        arg4.takerOrder = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::to_1x9(arg4.takerOrder);
        let v0 = arg4.fill;
        let v1 = arg4.currentTime;
        let v2 = &mut arg4.makerOrder;
        let v3 = &mut arg4.takerOrder;
        assert!(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::isBuy(*v2) != 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::isBuy(*v3), 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::error::order_cannot_be_of_same_side());
        let v4 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::perpetual::priceOracle(arg1);
        let v5 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::perpetual::checks(arg1);
        let v6 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::perpetual::imr(arg1);
        let v7 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::perpetual::mmr(arg1);
        let v8 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::perpetual::positions(arg1);
        let v9 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::get_serialized_order(arg4.makerOrder);
        let v10 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::get_serialized_order(arg4.takerOrder);
        let v11 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::get_hash(v9);
        let v12 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::get_hash(v10);
        0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::create_order(arg2, v11);
        0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::create_order(arg2, v12);
        if (0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::price(*v3) == 0) {
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::set_price(v3, v0.price);
        };
        0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::set_leverage(v2, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::round_down(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::leverage(*v2)));
        0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::set_leverage(v3, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::round_down(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::leverage(*v3)));
        let v13 = *0x2::table::borrow<address, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::UserPosition>(v8, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::maker(*v2));
        let v14 = *0x2::table::borrow<address, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::UserPosition>(v8, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::maker(*v3));
        verify_order(v13, arg2, arg3, *v2, v9, v11, arg4.makerSignature, arg4.makerPublicKey, v0, v1, 0);
        verify_order(v14, arg2, arg3, *v3, v10, v12, arg4.takerSignature, arg4.takerPublicKey, v0, v1, 1);
        0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::evaluator::verify_price_checks(v5, v0.price);
        0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::evaluator::verify_qty_checks(v5, v0.quantity);
        0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::evaluator::verify_market_take_bound_checks(v5, v0.price, v4, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::isBuy(*v3));
        if (0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::maker(*v2) == 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::maker(*v3)) {
            return TradeResponse{
                makerFundsFlow : 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::new(),
                takerFundsFlow : 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::new(),
                fee            : 0,
            }
        };
        let v15 = 0x2::table::borrow_mut<address, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::UserPosition>(v8, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::maker(*v2));
        let v16 = apply_isolated_margin(v5, v15, *v2, v0, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(v0.price, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::perpetual::get_fee(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::maker(*v2), arg1, true)), 0);
        let v17 = 0x2::table::borrow_mut<address, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::UserPosition>(v8, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::maker(*v3));
        let v18 = apply_isolated_margin(v5, v17, *v3, v0, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(v0.price, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::perpetual::get_fee(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::maker(*v3), arg1, false)), 1);
        let v19 = *0x2::table::borrow<address, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::UserPosition>(v8, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::maker(*v2));
        let v20 = *0x2::table::borrow<address, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::UserPosition>(v8, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::maker(*v3));
        0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::verify_collat_checks(v13, v19, v6, v7, v4, 1, 0);
        0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::verify_collat_checks(v14, v20, v6, v7, v4, 1, 1);
        0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::emit_position_update_event(v19, arg0, 0);
        0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::emit_position_update_event(v20, arg0, 0);
        let v21 = TradeExecuted{
            sender         : arg0,
            perpID         : 0x2::object::uid_to_inner(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::perpetual::id(arg1)),
            tradeType      : 1,
            maker          : 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::maker(*v2),
            taker          : 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::maker(*v3),
            makerOrderHash : v11,
            takerOrderHash : v12,
            makerMRO       : 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::mro(v19),
            takerMRO       : 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::mro(v20),
            makerFee       : v16.fee,
            takerFee       : v18.fee,
            makerPnl       : v16.pnl,
            takerPnl       : v18.pnl,
            tradeQuantity  : v0.quantity,
            tradePrice     : v0.price,
            isBuy          : 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::isBuy(*v3),
        };
        0x2::event::emit<TradeExecuted>(v21);
        TradeResponse{
            makerFundsFlow : v16.fundsFlow,
            takerFundsFlow : v18.fundsFlow,
            fee            : v18.fee + v16.fee,
        }
    }

    public(friend) fun tradeType() : u8 {
        1
    }

    fun verify_order(arg0: 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::UserPosition, arg1: &mut 0x2::table::Table<vector<u8>, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::OrderStatus>, arg2: &0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::roles::SubAccounts, arg3: 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::Order, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: Fill, arg9: u64, arg10: u64) {
        assert!(arg10 == 0 || !0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::postOnly(arg3), 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::error::taker_order_can_not_be_post_only());
        assert!(arg10 == 1 || !0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::ioc(arg3), 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::error::maker_order_can_not_be_ioc());
        0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::verify_order_state(arg1, arg5, arg10);
        0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::verify_order_expiry(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::expiration(arg3), arg9, arg10);
        0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::verify_order_leverage(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::mro(arg0), 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::leverage(arg3), arg10);
        0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::verify_and_fill_order_qty(arg1, arg3, arg5, arg8.price, arg8.quantity, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::isPosPositive(arg0), 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::qPos(arg0), 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::verify_order_signature(arg2, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::order::maker(arg3), arg4, arg6, arg7, arg10), arg10);
    }

    // decompiled from Move bytecode v6
}

