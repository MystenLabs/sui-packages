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

    struct TradeDataV2 has copy, drop {
        maker_order: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderV2,
        taker_order: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderV2,
        maker_signatory: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress,
        maker_payload_version: u32,
        taker_signatory: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress,
        taker_payload_version: u32,
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

    fun apply_isolated_margin(arg0: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::TradeChecks, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position, arg2: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderV2, arg3: Fill, arg4: u128, arg5: u64, arg6: bool, arg7: bool) : IMResponse {
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::is_long(&arg2);
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
            assert!(!arg7, 118);
            let v8 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul_up(arg3.price, v4);
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_oi_open(arg1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::oi_open(arg1) + 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(arg3.quantity, arg3.price));
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_size(arg1, v1 + arg3.quantity);
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_margin(arg1, v3 + 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(arg3.quantity, v8));
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_is_long(arg1, v0);
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::verify_oi_open_for_account(arg0, v4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::oi_open(arg1), arg5, arg6);
            (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul_up(arg3.quantity, v8 + arg4), true), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::zero())
        } else if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::reduce_only(arg2) || v0 != v2 && arg3.quantity <= v1) {
            let v9 = v1 - arg3.quantity;
            if (!arg7) {
                let v10 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(v5, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(v3, v1));
                assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::gte_u128(v10, 0), arg5 + 46);
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
            assert!(!arg7, 118);
            let v14 = arg3.quantity - v1;
            let v15 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(v14, arg3.price);
            let v16 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(v5, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(v3, v1));
            assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::gte_u128(v16, 0), arg5 + 46);
            let v17 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::positive_value(v16);
            let v18 = if (arg4 > v17) {
                v17
            } else {
                arg4
            };
            let v6 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::sub_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::mul_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::negate(v5), v18), v1), v3), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul_up(v14, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul_up(arg3.price, v4) + arg4));
            let v19 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul_up(v1, v18) + 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul_up(v14, arg4);
            arg4 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div_up(v19, arg3.quantity);
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
            trade_fee  : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul_up(arg4, arg3.quantity),
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

    public(friend) fun pack_trade_data(arg0: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderV2, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: u32, arg3: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderV2, arg4: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg5: u32, arg6: u128, arg7: u128, arg8: u64) : TradeDataV2 {
        let v0 = Fill{
            quantity : arg6,
            price    : arg7,
        };
        TradeDataV2{
            maker_order           : arg0,
            taker_order           : arg3,
            maker_signatory       : arg1,
            maker_payload_version : arg2,
            taker_signatory       : arg4,
            taker_payload_version : arg5,
            fill                  : v0,
            current_time          : arg8,
        }
    }

    public(friend) fun taker_funds_flow(arg0: TradeResponse) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128 {
        arg0.taker_funds_flow
    }

    public(friend) fun trade(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: address, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x2::table::Table<vector<u8>, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderStatus>, arg4: TradeDataV2, arg5: u128) : TradeResponse {
        arg4.fill.quantity = arg4.fill.quantity / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint();
        arg4.fill.price = arg4.fill.price / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint();
        arg4.maker_order = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::to_1x9(arg4.maker_order);
        arg4.taker_order = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::to_1x9(arg4.taker_order);
        let v0 = arg4.fill;
        let v1 = arg4.current_time;
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::creator_identifier(&arg4.maker_order);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::creator_identifier(&arg4.taker_order);
        let v4 = &mut arg4.maker_order;
        let v5 = &mut arg4.taker_order;
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::is_long(v4) != 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::is_long(v5), 48);
        let v6 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::price_oracle(arg2);
        let v7 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::checks(arg2);
        let v8 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::imr(arg2);
        let v9 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::mmr(arg2);
        let v10 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::insurance_active_pool(arg2);
        let v11 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg2);
        let v12 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::to_json_bytes(arg4.maker_order, arg4.maker_payload_version));
        let v13 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::to_json_bytes(arg4.taker_order, arg4.taker_payload_version));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::create_order(arg3, v12);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::create_order(arg3, v13);
        let v14 = if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::price(*v5) == 0) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::set_price(v5, v0.price);
            true
        } else {
            false
        };
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::set_leverage(v4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::round_down(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::leverage(*v4)));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::set_leverage(v5, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::round_down(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::leverage(*v5)));
        let v15 = *0x2::table::borrow<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(v11, v2);
        let v16 = *0x2::table::borrow<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(v11, v3);
        verify_order(v15, arg3, *v4, v12, arg4.maker_signatory, v0, v1, 0, arg5, v10 == v2);
        verify_order(v16, arg3, *v5, v13, arg4.taker_signatory, v0, v1, 1, arg5, v10 == v3);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::verify_price_checks(v7, v0.price);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::verify_qty_checks(v7, v0.quantity, v14);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::verify_market_take_bound_checks(v7, v0.price, v6, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::is_long(v5));
        let v17 = caculate_gas_fee(arg3, v12, v0.quantity, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::maker_gas_fee(arg0));
        let v18 = caculate_gas_fee(arg3, v13, v0.quantity, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::taker_gas_fee(arg0));
        if (v2 == v3) {
            let v19 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(v0.price, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::get_fee(arg2, v2, true)), v0.quantity);
            let v20 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(v0.price, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::get_fee(arg2, v3, false)), v0.quantity);
            let v21 = TradeExecutedEvent{
                tx_index         : arg5,
                sender           : arg1,
                perp_id          : 0x2::object::uid_to_inner(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::id(arg2)),
                trade_type       : 1,
                maker            : v2,
                taker            : v3,
                make_order_hash  : v12,
                taker_order_hash : v13,
                maker_mro        : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::mro(&v15),
                taker_mro        : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::mro(&v16),
                maker_trade_fee  : v19,
                maker_gas_fee    : v17,
                taker_trade_fee  : v20,
                taker_gas_fee    : v18,
                maker_pnl        : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::zero(),
                taker_pnl        : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::zero(),
                trade_quantity   : v0.quantity,
                trade_price      : v0.price,
                is_long          : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::is_long(v5),
            };
            0x2::event::emit<TradeExecutedEvent>(v21);
            return TradeResponse{
                maker_funds_flow : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from(v19, true), v17),
                taker_funds_flow : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from(v20, true), v18),
                trade_fee        : v19 + v20,
                gas_fee          : v17 + v18,
            }
        };
        let v22 = 0x2::table::borrow_mut<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(v11, v2);
        let v23 = apply_isolated_margin(v7, v22, *v4, v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul_up(v0.price, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::get_fee(arg2, v2, true)), 0, 0x2::vec_set::contains<address>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::privileged_addresses(arg0), &v2), v10 == v2);
        let v24 = 0x2::table::borrow_mut<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(v11, v3);
        let v25 = apply_isolated_margin(v7, v24, *v5, v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul_up(v0.price, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::get_fee(arg2, v3, false)), 1, 0x2::vec_set::contains<address>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::privileged_addresses(arg0), &v3), v10 == v3);
        let v26 = *0x2::table::borrow<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(v11, v2);
        let v27 = *0x2::table::borrow<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(v11, v3);
        if (v10 != v2) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::verify_collat_checks(&v15, &v26, v8, v9, v6, 1, 0);
        };
        if (v10 != v3) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::verify_collat_checks(&v16, &v27, v8, v9, v6, 1, 1);
        };
        v23.funds_flow = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(v23.funds_flow, v17);
        v25.funds_flow = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(v25.funds_flow, v18);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::emit_position_update_event(v26, arg1, 0, arg5);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::emit_position_update_event(v27, arg1, 0, arg5);
        let v28 = TradeExecutedEvent{
            tx_index         : arg5,
            sender           : arg1,
            perp_id          : 0x2::object::uid_to_inner(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::id(arg2)),
            trade_type       : 1,
            maker            : v2,
            taker            : v3,
            make_order_hash  : v12,
            taker_order_hash : v13,
            maker_mro        : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::mro(&v26),
            taker_mro        : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::mro(&v27),
            maker_trade_fee  : v23.trade_fee,
            maker_gas_fee    : v17,
            taker_trade_fee  : v25.trade_fee,
            taker_gas_fee    : v18,
            maker_pnl        : v23.pnl,
            taker_pnl        : v25.pnl,
            trade_quantity   : v0.quantity,
            trade_price      : v0.price,
            is_long          : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::is_long(v5),
        };
        0x2::event::emit<TradeExecutedEvent>(v28);
        TradeResponse{
            maker_funds_flow : v23.funds_flow,
            taker_funds_flow : v25.funds_flow,
            trade_fee        : v25.trade_fee + v23.trade_fee,
            gas_fee          : v17 + v18,
        }
    }

    public(friend) fun trade_fee(arg0: TradeResponse) : u128 {
        arg0.trade_fee
    }

    public(friend) fun trade_type() : u8 {
        1
    }

    fun verify_order(arg0: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position, arg1: &mut 0x2::table::Table<vector<u8>, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderStatus>, arg2: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderV2, arg3: vector<u8>, arg4: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg5: Fill, arg6: u64, arg7: u64, arg8: u128, arg9: bool) {
        assert!(arg7 == 0 || !0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::post_only(arg2), 49);
        assert!(arg7 == 1 || !0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::ioc(arg2), 106);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::verify_order_state(arg1, arg3, arg7);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::verify_order_expiry(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::expiration(arg2), arg6, arg7);
        if (!arg9) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::verify_order_leverage(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::mro(&arg0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::leverage(arg2), arg7);
        };
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::verify_and_fill_order_qty(arg1, arg2, arg3, arg5.price, arg5.quantity, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::is_long(&arg0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(&arg0), arg4, arg7, arg8);
    }

    // decompiled from Move bytecode v7
}

