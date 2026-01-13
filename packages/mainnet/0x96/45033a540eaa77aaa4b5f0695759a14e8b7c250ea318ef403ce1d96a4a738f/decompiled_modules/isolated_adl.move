module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_adl {
    struct TradeExecutedEvent has copy, drop {
        tx_index: u128,
        sender: address,
        perp_id: 0x2::object::ID,
        trade_type: u8,
        maker: address,
        taker: address,
        maker_mro: u128,
        taker_mro: u128,
        maker_pnl: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128,
        taker_pnl: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128,
        trade_quantity: u128,
        trade_price: u128,
        is_long: bool,
    }

    struct TradeData has copy, drop {
        maker: address,
        taker: address,
        quantity: u128,
        all_or_nothing: bool,
    }

    struct IMResponse has drop {
        funds_flow: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128,
        pnl: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128,
    }

    struct TradeResponse has copy, drop {
        maker_funds_flow: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128,
        taker_funds_flow: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128,
    }

    fun apply_isolated_margin(arg0: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position, arg1: u128, arg2: u128, arg3: u64) : IMResponse {
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(arg0);
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(arg0);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::compute_pnl_per_unit(arg0, arg2);
        let v3 = v0 - arg1;
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::gte_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(v1, v0), true), v2), 100000), 0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::loss_exceeds_margin(arg3));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_margin(arg0, v1 * v3 / v0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_oi_open(arg0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::oi_open(arg0) * v3 / v0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_size(arg0, v3);
        IMResponse{
            funds_flow : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::negative_number(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::sub_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::mul_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::negate(v2), arg1), v1 * arg1 / v0)),
            pnl        : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::mul_u128(v2, arg1),
        }
    }

    public(friend) fun maker_funds_flow(arg0: TradeResponse) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128 {
        arg0.maker_funds_flow
    }

    public(friend) fun pack_trade_data(arg0: address, arg1: address, arg2: u128, arg3: bool) : TradeData {
        TradeData{
            maker          : arg0,
            taker          : arg1,
            quantity       : arg2,
            all_or_nothing : arg3,
        }
    }

    public(friend) fun taker_funds_flow(arg0: TradeResponse) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128 {
        arg0.taker_funds_flow
    }

    public(friend) fun trade<T0>(arg0: address, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg2: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: TradeData, arg4: u128) : TradeResponse {
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::imr(arg1);
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::mmr(arg1);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::checks(arg1);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::insurance_active_pool(arg1);
        let v4 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg1);
        let v5 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::round(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::price_oracle(arg1), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::tick_size(v2));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::verify_min_max_price(v2, v5);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::verify_qty_checks_liquidation(v2, arg3.quantity);
        let v6 = *0x2::table::borrow<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(v4, arg3.maker);
        let v7 = *0x2::table::borrow<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(v4, arg3.taker);
        if (arg3.maker == v3) {
            assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(&v6) == 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::unreachable());
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_margin(&mut v6, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg2, arg3.maker));
        };
        if (arg3.taker == v3) {
            assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(&v7) == 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::unreachable());
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_margin(&mut v7, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg2, arg3.taker));
        };
        let v8 = v6;
        let v9 = v7;
        verify_trade(&v6, &v7, arg3, v5);
        let v10 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::compute_bankruptcy_price(&v6);
        let v11 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::min(arg3.quantity, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::min(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(&v6), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(&v7)));
        let v12 = &mut v6;
        let v13 = apply_isolated_margin(v12, v11, v10, 0);
        let v14 = &mut v7;
        let v15 = apply_isolated_margin(v14, v11, v10, 1);
        if (v3 != arg3.maker) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::verify_collat_checks(&v8, &v6, v0, v1, v5, 3, 0);
        } else {
            v13.funds_flow = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add(v13.funds_flow, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::sub(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(&v8), true), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(&v6), true)));
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_margin(&mut v6, 0);
        };
        if (v3 != arg3.taker) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::verify_collat_checks(&v9, &v7, v0, v1, v5, 3, 1);
        } else {
            v15.funds_flow = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::add(v15.funds_flow, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::sub(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(&v9), true), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::from(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(&v7), true)));
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_margin(&mut v7, 0);
        };
        let v16 = 0x2::table::borrow_mut<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(v4, arg3.maker);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_margin(v16, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(&v6));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_oi_open(v16, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::oi_open(&v6));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_size(v16, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(&v6));
        let v17 = 0x2::table::borrow_mut<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(v4, arg3.taker);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_margin(v17, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(&v7));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_oi_open(v17, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::oi_open(&v7));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_size(v17, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(&v7));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::emit_position_update_event(v6, arg0, 0, arg4);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::emit_position_update_event(v7, arg0, 0, arg4);
        let v18 = TradeExecutedEvent{
            tx_index       : arg4,
            sender         : arg0,
            perp_id        : 0x2::object::uid_to_inner(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::id(arg1)),
            trade_type     : 3,
            maker          : arg3.maker,
            taker          : arg3.taker,
            maker_mro      : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::mro(&v6),
            taker_mro      : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::mro(&v7),
            maker_pnl      : v13.pnl,
            taker_pnl      : v15.pnl,
            trade_quantity : arg3.quantity,
            trade_price    : v10,
            is_long        : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::is_long(&v6),
        };
        0x2::event::emit<TradeExecutedEvent>(v18);
        TradeResponse{
            maker_funds_flow : v13.funds_flow,
            taker_funds_flow : v15.funds_flow,
        }
    }

    public(friend) fun trade_type() : u8 {
        3
    }

    fun verify_account(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position, arg1: TradeData, arg2: u64) {
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(arg0) > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::user_position_size_is_zero(arg2));
        assert!(!arg1.all_or_nothing || 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(arg0) >= arg1.quantity, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::adl_all_or_nothing_constraint_can_not_be_held(arg2));
    }

    fun verify_trade(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position, arg2: TradeData, arg3: u128) {
        verify_account(arg0, arg2, 0);
        verify_account(arg1, arg2, 1);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::lte_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::compute_margin_ratio(arg0, arg3), 0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::maker_is_not_underwater());
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::gt_u128(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::compute_margin_ratio(arg1, arg3), 0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::taker_is_under_underwater());
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::is_long(arg0) != 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::is_long(arg1), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::maker_taker_must_have_opposite_side_positions());
    }

    // decompiled from Move bytecode v6
}

