module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_trading {
    struct TradeExecutedEvent has copy, drop {
        tx_index: u128,
        sender: address,
        perp_id: 0x2::object::ID,
        trade_type: u8,
        maker: address,
        taker: address,
        make_order_hash: vector<u8>,
        taker_order_hash: vector<u8>,
        maker_mro: u128,
        taker_mro: u128,
        maker_trade_fee: u128,
        maker_gas_fee: u128,
        taker_trade_fee: u128,
        taker_gas_fee: u128,
        maker_pnl: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128,
        taker_pnl: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128,
        trade_quantity: u128,
        trade_price: u128,
        is_long: bool,
    }

    struct TradeData has copy, drop {
        maker_signature: vector<u8>,
        taker_signature: vector<u8>,
        maker_publicKey: vector<u8>,
        taker_publicKey: vector<u8>,
        maker_order: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::Order,
        taker_order: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::Order,
        fill: Fill,
        current_time: u64,
    }

    struct Fill has copy, drop {
        quantity: u128,
        price: u128,
    }

    struct IMResponse has drop {
        funds_flow: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128,
        pnl: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128,
        trade_fee: u128,
    }

    struct TradeResponse has copy, drop, store {
        maker_funds_flow: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128,
        taker_funds_flow: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128,
        trade_fee: u128,
        gas_fee: u128,
    }

    fun apply_isolated_margin(arg0: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::TradeChecks, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position, arg2: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::Order, arg3: Fill, arg4: u128, arg5: u64, arg6: bool, arg7: bool) : IMResponse {
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::is_long(arg2);
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(arg1);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::is_long(arg1);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(arg1);
        let v4 = if (arg7) {
            0
        } else {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::compute_mro(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::leverage(arg2))
        };
        let v5 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::compute_pnl_per_unit(arg1, arg3.price);
        let (v6, v7) = if (v1 == 0 || v0 == v2) {
            assert!(!arg7, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::unreachable());
            let v8 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(arg3.price, v4);
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_oi_open(arg1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::oi_open(arg1) + 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(arg3.quantity, arg3.price));
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_size(arg1, v1 + arg3.quantity);
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_margin(arg1, v3 + 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(arg3.quantity, v8));
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_is_long(arg1, v0);
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::verify_oi_open_for_account(arg0, v4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::oi_open(arg1), arg5, arg6);
            (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(arg3.quantity, v8 + arg4), true), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::zero())
        } else if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::reduce_only(arg2) || v0 != v2 && arg3.quantity <= v1) {
            let v9 = v1 - arg3.quantity;
            if (!arg7) {
                let v10 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(v5, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(v3, v1));
                assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::gte_u128(v10, 0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::loss_exceeds_margin(arg5));
                let v11 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::positive_value(v10);
                let v12 = if (arg4 > v11) {
                    v11
                } else {
                    arg4
                };
                arg4 = v12;
            };
            let v13 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::sub_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::mul_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::negate(v5), arg4), arg3.quantity), v3 * arg3.quantity / v1);
            let v6 = v13;
            if (!arg7) {
                v6 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::negative_number(v13);
            };
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_margin(arg1, v3 * v9 / v1);
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_oi_open(arg1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::oi_open(arg1) * v9 / v1);
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_size(arg1, v9);
            (v6, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::mul_u128(v5, arg3.quantity))
        } else {
            assert!(!arg7, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::unreachable());
            let v14 = arg3.quantity - v1;
            let v15 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(v14, arg3.price);
            let v16 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(v5, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(v3, v1));
            assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::gte_u128(v16, 0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::loss_exceeds_margin(arg5));
            let v17 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::positive_value(v16);
            let v18 = if (arg4 > v17) {
                v17
            } else {
                arg4
            };
            let v6 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::sub_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::mul_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::negate(v5), v18), v1), v3), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(v14, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(arg3.price, v4) + arg4));
            let v19 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(v1, v18) + 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(v14, arg4);
            arg4 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(v19, arg3.quantity);
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::verify_oi_open_for_account(arg0, v4, v15, arg5, arg6);
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_size(arg1, v14);
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_oi_open(arg1, v15);
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_margin(arg1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(v14, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(arg3.price, v4)));
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_is_long(arg1, !v2);
            (v6, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::mul_u128(v5, v1))
        };
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_mro(arg1, v4);
        IMResponse{
            funds_flow : v6,
            pnl        : v7,
            trade_fee  : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(arg4, arg3.quantity),
        }
    }

    fun caculate_gas_fee(arg0: &0x2::table::Table<vector<u8>, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderStatus>, arg1: vector<u8>, arg2: u128, arg3: u128) : u128 {
        if (arg3 == 0) {
            return 0
        };
        if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::get_filled_qty(0x2::table::borrow<vector<u8>, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderStatus>(arg0, arg1)) == arg2) {
            return arg3
        };
        0
    }

    public(friend) fun gas_fee(arg0: TradeResponse) : u128 {
        arg0.gas_fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x2::table::Table<vector<u8>, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderStatus>>(0x2::table::new<vector<u8>, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderStatus>(arg0));
    }

    public(friend) fun maker_funds_flow(arg0: TradeResponse) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128 {
        arg0.maker_funds_flow
    }

    public(friend) fun pack_trade_data(arg0: u8, arg1: u128, arg2: u128, arg3: u128, arg4: address, arg5: u64, arg6: u128, arg7: vector<u8>, arg8: vector<u8>, arg9: u8, arg10: u128, arg11: u128, arg12: u128, arg13: address, arg14: u64, arg15: u128, arg16: vector<u8>, arg17: vector<u8>, arg18: u128, arg19: u128, arg20: address, arg21: u64) : TradeData {
        let v0 = Fill{
            quantity : arg18,
            price    : arg19,
        };
        TradeData{
            maker_signature : arg7,
            taker_signature : arg16,
            maker_publicKey : arg8,
            taker_publicKey : arg17,
            maker_order     : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::pack_order(arg20, arg0, arg1, arg2, arg3, arg4, arg5, arg6),
            taker_order     : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::pack_order(arg20, arg9, arg10, arg11, arg12, arg13, arg14, arg15),
            fill            : v0,
            current_time    : arg21,
        }
    }

    public(friend) fun taker_funds_flow(arg0: TradeResponse) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128 {
        arg0.taker_funds_flow
    }

    public(friend) fun trade(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: address, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x2::table::Table<vector<u8>, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderStatus>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: TradeData, arg6: u128) : TradeResponse {
        arg5.fill.quantity = arg5.fill.quantity / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint();
        arg5.fill.price = arg5.fill.price / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint();
        arg5.maker_order = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::to_1x9(arg5.maker_order);
        arg5.taker_order = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::to_1x9(arg5.taker_order);
        let v0 = arg5.fill;
        let v1 = arg5.current_time;
        let v2 = &mut arg5.maker_order;
        let v3 = &mut arg5.taker_order;
        let v4 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::creator(*v2);
        let v5 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::creator(*v3);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::is_long(*v2) != 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::is_long(*v3), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::order_cannot_be_of_same_side());
        let v6 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::price_oracle(arg2);
        let v7 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::checks(arg2);
        let v8 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::imr(arg2);
        let v9 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::mmr(arg2);
        let v10 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::insurance_active_pool(arg2);
        let v11 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg2);
        let v12 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::get_serialized_order(arg5.maker_order);
        let v13 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::get_serialized_order(arg5.taker_order);
        let v14 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v12);
        let v15 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v13);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::create_order(arg3, v14);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::create_order(arg3, v15);
        if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::price(*v3) == 0) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::set_price(v3, v0.price);
        };
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::set_leverage(v2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::round_down(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::leverage(*v2)));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::set_leverage(v3, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::round_down(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::leverage(*v3)));
        let v16 = *0x2::table::borrow<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(v11, v4);
        let v17 = *0x2::table::borrow<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(v11, v5);
        verify_order(v16, arg3, arg4, *v2, v12, v14, arg5.maker_signature, arg5.maker_publicKey, v0, v1, 0, arg6, v10 == v4);
        verify_order(v17, arg3, arg4, *v3, v13, v15, arg5.taker_signature, arg5.taker_publicKey, v0, v1, 1, arg6, v10 == v5);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::verify_price_checks(v7, v0.price);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::verify_qty_checks(v7, v0.quantity);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::verify_market_take_bound_checks(v7, v0.price, v6, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::is_long(*v3));
        let v18 = caculate_gas_fee(arg3, v14, v0.quantity, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::maker_gas_fee(arg0));
        let v19 = caculate_gas_fee(arg3, v15, v0.quantity, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::taker_gas_fee(arg0));
        if (v4 == v5) {
            let v20 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(v0.price, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::get_fee(v4, arg2, true)), v0.quantity);
            let v21 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(v0.price, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::get_fee(v5, arg2, false)), v0.quantity);
            let v22 = TradeExecutedEvent{
                tx_index         : arg6,
                sender           : arg1,
                perp_id          : 0x2::object::uid_to_inner(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::id(arg2)),
                trade_type       : 1,
                maker            : v4,
                taker            : v5,
                make_order_hash  : v14,
                taker_order_hash : v15,
                maker_mro        : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::mro(&v16),
                taker_mro        : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::mro(&v17),
                maker_trade_fee  : v20,
                maker_gas_fee    : v18,
                taker_trade_fee  : v21,
                taker_gas_fee    : v19,
                maker_pnl        : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::zero(),
                taker_pnl        : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::zero(),
                trade_quantity   : v0.quantity,
                trade_price      : v0.price,
                is_long          : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::is_long(*v3),
            };
            0x2::event::emit<TradeExecutedEvent>(v22);
            return TradeResponse{
                maker_funds_flow : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from(v20, true), v18),
                taker_funds_flow : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from(v21, true), v19),
                trade_fee        : v20 + v21,
                gas_fee          : v18 + v19,
            }
        };
        let v23 = 0x2::table::borrow_mut<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(v11, v4);
        let v24 = apply_isolated_margin(v7, v23, *v2, v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(v0.price, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::get_fee(v4, arg2, true)), 0, 0x2::vec_set::contains<address>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::privileged_addresses(arg0), &v4), v10 == v4);
        let v25 = 0x2::table::borrow_mut<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(v11, v5);
        let v26 = apply_isolated_margin(v7, v25, *v3, v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(v0.price, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::get_fee(v5, arg2, false)), 1, 0x2::vec_set::contains<address>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::privileged_addresses(arg0), &v5), v10 == v5);
        let v27 = *0x2::table::borrow<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(v11, v4);
        let v28 = *0x2::table::borrow<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(v11, v5);
        if (v10 != v4) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::verify_collat_checks(&v16, &v27, v8, v9, v6, 1, 0);
        };
        if (v10 != v5) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::verify_collat_checks(&v17, &v28, v8, v9, v6, 1, 1);
        };
        v24.funds_flow = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(v24.funds_flow, v18);
        v26.funds_flow = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(v26.funds_flow, v19);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::emit_position_update_event(v27, arg1, 0, arg6);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::emit_position_update_event(v28, arg1, 0, arg6);
        let v29 = TradeExecutedEvent{
            tx_index         : arg6,
            sender           : arg1,
            perp_id          : 0x2::object::uid_to_inner(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::id(arg2)),
            trade_type       : 1,
            maker            : v4,
            taker            : v5,
            make_order_hash  : v14,
            taker_order_hash : v15,
            maker_mro        : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::mro(&v27),
            taker_mro        : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::mro(&v28),
            maker_trade_fee  : v24.trade_fee,
            maker_gas_fee    : v18,
            taker_trade_fee  : v26.trade_fee,
            taker_gas_fee    : v19,
            maker_pnl        : v24.pnl,
            taker_pnl        : v26.pnl,
            trade_quantity   : v0.quantity,
            trade_price      : v0.price,
            is_long          : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::is_long(*v3),
        };
        0x2::event::emit<TradeExecutedEvent>(v29);
        TradeResponse{
            maker_funds_flow : v24.funds_flow,
            taker_funds_flow : v26.funds_flow,
            trade_fee        : v26.trade_fee + v24.trade_fee,
            gas_fee          : v18 + v19,
        }
    }

    public(friend) fun trade_fee(arg0: TradeResponse) : u128 {
        arg0.trade_fee
    }

    public(friend) fun trade_type() : u8 {
        1
    }

    fun verify_order(arg0: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position, arg1: &mut 0x2::table::Table<vector<u8>, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderStatus>, arg2: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg3: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::Order, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: Fill, arg9: u64, arg10: u64, arg11: u128, arg12: bool) {
        assert!(arg10 == 0 || !0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::post_only(arg3), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::taker_order_can_not_be_post_only());
        assert!(arg10 == 1 || !0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::ioc(arg3), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::maker_order_can_not_be_ioc());
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::verify_order_state(arg1, arg5, arg10);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::verify_order_expiry(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::expiration(arg3), arg9, arg10);
        if (!arg12) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::verify_order_leverage(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::mro(&arg0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::leverage(arg3), arg10);
        };
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::verify_and_fill_order_qty(arg1, arg3, arg5, arg8.price, arg8.quantity, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::is_long(&arg0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(&arg0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::verify_order_signature(arg2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::creator(arg3), arg4, arg6, arg7, arg10), arg10, arg11);
    }

    // decompiled from Move bytecode v6
}

