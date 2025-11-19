module 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders {
    struct OpenPositionOrder<phantom T0, phantom T1> has store {
        executed: bool,
        created_at: u64,
        open_amount: u64,
        reserve_amount: u64,
        limited_index_price: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice,
        collateral_price_threshold: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        position_config: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::PositionConfig,
        collateral: 0x2::balance::Balance<T0>,
        fee: 0x2::balance::Balance<T1>,
    }

    struct OpenPositionOrderV1_1<phantom T0, phantom T1> has store {
        executed: bool,
        created_at: u64,
        open_amount: u64,
        reserve_amount: u64,
        limited_index_price: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        collateral_price_threshold: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        position_config: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::PositionConfig,
        collateral: 0x2::balance::Balance<T0>,
        fee: 0x2::balance::Balance<T1>,
    }

    struct DecreasePositionOrder<phantom T0> has store {
        executed: bool,
        created_at: u64,
        take_profit: bool,
        decrease_amount: u64,
        limited_index_price: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice,
        collateral_price_threshold: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        fee: 0x2::balance::Balance<T0>,
    }

    struct DecreasePositionOrderV1_1<phantom T0> has store {
        executed: bool,
        created_at: u64,
        take_profit: bool,
        decrease_amount: u64,
        limited_index_price: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        collateral_price_threshold: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        fee: 0x2::balance::Balance<T0>,
    }

    struct OpenPositionOrderV2<phantom T0, phantom T1> has store {
        executed: bool,
        created_at: u64,
        open_amount: u64,
        reserve_amount: u64,
        limited_index_price: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        collateral_price_threshold: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        position_config: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::PositionConfig,
        collateral: 0x2::balance::Balance<T0>,
        fee: 0x2::balance::Balance<T1>,
        scard_id: 0x1::option::Option<0x2::object::ID>,
        scard_rebate_rate: 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate>,
        referrer: address,
    }

    struct DecreasePositionOrderV2<phantom T0> has store {
        executed: bool,
        created_at: u64,
        take_profit: bool,
        decrease_amount: u64,
        limited_index_price: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        collateral_price_threshold: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        fee: 0x2::balance::Balance<T0>,
        scard_id: 0x1::option::Option<0x2::object::ID>,
        scard_rebate_rate: 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate>,
        referrer: address,
    }

    struct CreateOpenPositionOrderEvent has copy, drop {
        open_amount: u64,
        reserve_amount: u64,
        limited_index_price: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        collateral_price_threshold: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        position_config: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::PositionConfig,
        collateral_amount: u64,
        fee_amount: u64,
    }

    struct CreateDecreasePositionOrderEvent has copy, drop {
        take_profit: bool,
        decrease_amount: u64,
        limited_index_price: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        collateral_price_threshold: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        fee_amount: u64,
    }

    struct CreateOpenPositionOrderV2Event has copy, drop {
        open_amount: u64,
        reserve_amount: u64,
        limited_index_price: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        collateral_price_threshold: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        position_config: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::PositionConfig,
        collateral_amount: u64,
        fee_amount: u64,
        scard_id: 0x1::option::Option<0x2::object::ID>,
        scard_rebate_rate: 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate>,
    }

    struct CreateDecreasePositionOrderV2Event has copy, drop {
        take_profit: bool,
        decrease_amount: u64,
        limited_index_price: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        collateral_price_threshold: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        fee_amount: u64,
        scard_id: 0x1::option::Option<0x2::object::ID>,
        scard_rebate_rate: 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate>,
    }

    public(friend) fun destroy_decrease_position_order<T0>(arg0: DecreasePositionOrder<T0>) : 0x2::balance::Balance<T0> {
        let DecreasePositionOrder {
            executed                   : _,
            created_at                 : _,
            take_profit                : _,
            decrease_amount            : _,
            limited_index_price        : _,
            collateral_price_threshold : _,
            fee                        : v6,
        } = arg0;
        v6
    }

    public(friend) fun destroy_decrease_position_order_v1_1<T0>(arg0: DecreasePositionOrderV1_1<T0>) : 0x2::balance::Balance<T0> {
        let DecreasePositionOrderV1_1 {
            executed                   : _,
            created_at                 : _,
            take_profit                : _,
            decrease_amount            : _,
            limited_index_price        : _,
            collateral_price_threshold : _,
            fee                        : v6,
        } = arg0;
        v6
    }

    public(friend) fun destroy_decrease_position_order_v2<T0>(arg0: DecreasePositionOrderV2<T0>) : 0x2::balance::Balance<T0> {
        let DecreasePositionOrderV2 {
            executed                   : _,
            created_at                 : _,
            take_profit                : _,
            decrease_amount            : _,
            limited_index_price        : _,
            collateral_price_threshold : _,
            fee                        : v6,
            scard_id                   : _,
            scard_rebate_rate          : _,
            referrer                   : _,
        } = arg0;
        v6
    }

    public(friend) fun destroy_open_position_order<T0, T1>(arg0: OpenPositionOrder<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let OpenPositionOrder {
            executed                   : _,
            created_at                 : _,
            open_amount                : _,
            reserve_amount             : _,
            limited_index_price        : _,
            collateral_price_threshold : _,
            position_config            : _,
            collateral                 : v7,
            fee                        : v8,
        } = arg0;
        (v7, v8)
    }

    public(friend) fun destroy_open_position_order_v1_1<T0, T1>(arg0: OpenPositionOrderV1_1<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let OpenPositionOrderV1_1 {
            executed                   : _,
            created_at                 : _,
            open_amount                : _,
            reserve_amount             : _,
            limited_index_price        : _,
            collateral_price_threshold : _,
            position_config            : _,
            collateral                 : v7,
            fee                        : v8,
        } = arg0;
        (v7, v8)
    }

    public(friend) fun destroy_open_position_order_v2<T0, T1>(arg0: OpenPositionOrderV2<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let OpenPositionOrderV2 {
            executed                   : _,
            created_at                 : _,
            open_amount                : _,
            reserve_amount             : _,
            limited_index_price        : _,
            collateral_price_threshold : _,
            position_config            : _,
            collateral                 : v7,
            fee                        : v8,
            scard_id                   : _,
            scard_rebate_rate          : _,
            referrer                   : _,
        } = arg0;
        (v7, v8)
    }

    public(friend) fun execute_decrease_position_order<T0, T1>(arg0: &mut DecreasePositionOrder<T1>, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T0>, arg2: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol, arg3: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T0>, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg5: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg6: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg7: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg8: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg9: bool, arg10: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg11: u64) : (u64, 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionResult<T0>>, 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionFailedEvent>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg9 && arg0.take_profit || !arg9 && !arg0.take_profit) {
            let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg7);
            let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(&arg0.limited_index_price);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v0, &v1), 302);
        } else {
            let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg7);
            let v3 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(&arg0.limited_index_price);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::le(&v2, &v3), 302);
        };
        arg0.executed = true;
        let (v4, v5, v6) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::decrease_position<T0>(arg1, arg2, arg3, arg4, arg5, arg6, &arg0.limited_index_price, arg0.collateral_price_threshold, arg8, arg9, arg0.decrease_amount, arg10, arg11);
        (v4, v5, v6, 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_decrease_position_order_v1_1<T0, T1>(arg0: &mut DecreasePositionOrderV1_1<T1>, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T0>, arg2: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol, arg3: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T0>, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg5: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg6: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg7: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg8: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg9: bool, arg10: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg11: u64) : (u64, 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionResult<T0>>, 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionFailedEvent>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg9 && arg0.take_profit || !arg9 && !arg0.take_profit) {
            let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg7);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg7);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::le(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::from_price(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(arg2), arg0.limited_index_price);
        let (v3, v4, v5) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::decrease_position<T0>(arg1, arg2, arg3, arg4, arg5, arg6, &v2, arg0.collateral_price_threshold, arg8, arg9, arg0.decrease_amount, arg10, arg11);
        (v3, v4, v5, 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_decrease_position_order_v1_2<T0, T1>(arg0: &mut DecreasePositionOrderV1_1<T1>, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T0>, arg2: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol, arg3: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T0>, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg5: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg6: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg7: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg8: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg9: bool, arg10: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg11: u64) : (u64, 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionResultV1_2<T0>>, 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionFailedEvent>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg9 && arg0.take_profit || !arg9 && !arg0.take_profit) {
            let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg7);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg7);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::le(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::from_price(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(arg2), arg0.limited_index_price);
        let (v3, v4, v5) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::decrease_position_v1_2<T0>(arg1, arg2, arg3, arg4, arg5, arg6, &v2, arg0.collateral_price_threshold, arg8, arg9, arg0.decrease_amount, arg10, arg11);
        (v3, v4, v5, 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_decrease_position_order_v1_3<T0, T1>(arg0: &mut DecreasePositionOrderV1_1<T1>, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T0>, arg2: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol, arg3: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T0>, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg5: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg6: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg7: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg8: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg9: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg10: bool, arg11: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg12: u64) : (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionResultV1_3<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg10 && arg0.take_profit || !arg10 && !arg0.take_profit) {
            let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg7);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg7);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::le(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::from_price(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(arg2), arg0.limited_index_price);
        (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::decrease_position_v1_3_1<T0>(arg1, arg2, arg3, arg4, arg5, arg6, &v2, arg0.collateral_price_threshold, arg8, arg9, arg10, arg0.decrease_amount, arg11, arg12), 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_decrease_position_order_v2<T0, T1>(arg0: &mut DecreasePositionOrderV2<T1>, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T0>, arg2: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::FeeConfig, arg4: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T0>, arg5: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg6: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg7: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg8: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg9: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg10: bool, arg11: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg12: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::PositionInstantExitFeeConfig, arg13: u64) : (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionResultV2<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg10 && arg0.take_profit || !arg10 && !arg0.take_profit) {
            let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg8);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg8);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::le(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::from_price(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(arg2), arg0.limited_index_price);
        (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::decrease_position_v2<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v2, arg0.collateral_price_threshold, arg9, arg0.scard_rebate_rate, arg10, arg0.decrease_amount, arg11, arg12, arg13, arg0.referrer), 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_decrease_position_order_v2_1<T0, T1>(arg0: &mut DecreasePositionOrderV2<T1>, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T0>, arg2: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::FeeConfig, arg4: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T0>, arg5: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg6: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg7: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg8: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg9: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg10: bool, arg11: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg12: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::PositionInstantExitFeeConfig, arg13: u64, arg14: bool) : (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionResultV2<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg10 && arg0.take_profit || !arg10 && !arg0.take_profit) {
            let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg8);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg8);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::le(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::from_price(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(arg2), arg0.limited_index_price);
        (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::decrease_position_v2_1<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v2, arg0.collateral_price_threshold, arg9, arg0.scard_rebate_rate, arg10, arg0.decrease_amount, arg11, arg12, arg13, arg0.referrer, arg14), 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_open_position_order<T0, T1>(arg0: &mut OpenPositionOrder<T0, T1>, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T0>, arg2: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg5: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg6: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg7: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg8: bool, arg9: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg10: u64) : (u64, 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionResult<T0>>, 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionFailedEvent>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg8) {
            let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg6);
            let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(&arg0.limited_index_price);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::le(&v0, &v1), 302);
        } else {
            let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg6);
            let v3 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(&arg0.limited_index_price);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v2, &v3), 302);
        };
        arg0.executed = true;
        let (v4, v5, v6) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::open_position<T0>(arg1, arg2, arg3, arg4, &arg0.position_config, arg5, &arg0.limited_index_price, &mut arg0.collateral, arg0.collateral_price_threshold, arg7, arg8, arg0.open_amount, arg0.reserve_amount, arg9, arg10);
        (v4, v5, v6, 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_open_position_order_v1_1<T0, T1>(arg0: &mut OpenPositionOrderV1_1<T0, T1>, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T0>, arg2: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg5: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg6: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg7: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg8: bool, arg9: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg10: u64) : (u64, 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionResult<T0>>, 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionFailedEvent>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg8) {
            let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg6);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::le(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg6);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::from_price(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(arg2), arg0.limited_index_price);
        let (v3, v4, v5) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::open_position<T0>(arg1, arg2, arg3, arg4, &arg0.position_config, arg5, &v2, &mut arg0.collateral, arg0.collateral_price_threshold, arg7, arg8, arg0.open_amount, arg0.reserve_amount, arg9, arg10);
        (v3, v4, v5, 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_open_position_order_v1_2<T0, T1>(arg0: &mut OpenPositionOrderV1_1<T0, T1>, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T0>, arg2: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg5: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg6: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg7: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg8: bool, arg9: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg10: u64) : (u64, 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionResultV1_2<T0>>, 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionFailedEvent>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg8) {
            let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg6);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::le(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg6);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::from_price(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(arg2), arg0.limited_index_price);
        let (v3, v4, v5) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::open_position_v1_2<T0>(arg1, arg2, arg3, arg4, &arg0.position_config, arg5, &v2, &mut arg0.collateral, arg0.collateral_price_threshold, arg7, arg8, arg0.open_amount, arg0.reserve_amount, arg9, arg10);
        (v3, v4, v5, 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_open_position_order_v1_3<T0, T1>(arg0: &mut OpenPositionOrderV1_1<T0, T1>, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T0>, arg2: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg5: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg6: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg7: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg8: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg9: bool, arg10: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg11: u64) : (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionResultV1_3<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg9) {
            let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg6);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::le(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg6);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::from_price(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(arg2), arg0.limited_index_price);
        (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::open_position_v1_3_1<T0>(arg1, arg2, arg3, arg4, &arg0.position_config, arg5, &v2, &mut arg0.collateral, arg0.collateral_price_threshold, arg7, arg8, arg9, arg0.open_amount, arg0.reserve_amount, arg10, arg11), 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_open_position_order_v2<T0, T1>(arg0: &mut OpenPositionOrderV2<T0, T1>, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T0>, arg2: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::FeeConfig, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg5: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg6: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg7: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg8: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg9: bool, arg10: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg11: u64) : (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionResultV2<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg9) {
            let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg7);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::le(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg7);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::from_price(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(arg2), arg0.limited_index_price);
        (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::open_position_v2<T0>(arg1, arg2, arg3, arg4, arg5, &arg0.position_config, arg6, &v2, &mut arg0.collateral, arg0.collateral_price_threshold, arg8, arg0.scard_rebate_rate, arg9, arg0.open_amount, arg0.reserve_amount, arg10, arg11, arg0.referrer), 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_open_position_order_v2_1<T0, T1>(arg0: &mut OpenPositionOrderV2<T0, T1>, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T0>, arg2: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::FeeConfig, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg5: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg6: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg7: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg8: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg9: bool, arg10: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg11: u64, arg12: bool) : (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionResultV2<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg9) {
            let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg7);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::le(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg7);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::from_price(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(arg2), arg0.limited_index_price);
        (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::open_position_v2_1<T0>(arg1, arg2, arg3, arg4, arg5, &arg0.position_config, arg6, &v2, &mut arg0.collateral, arg0.collateral_price_threshold, arg8, arg0.scard_rebate_rate, arg9, arg0.open_amount, arg0.reserve_amount, arg10, arg11, arg0.referrer, arg12), 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun get_scard_id_from_decrease_order_v2<T0>(arg0: &DecreasePositionOrderV2<T0>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.scard_id
    }

    public(friend) fun get_scard_id_from_open_order_v2<T0, T1>(arg0: &OpenPositionOrderV2<T0, T1>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.scard_id
    }

    public(friend) fun new_decrease_position_order<T0>(arg0: u64, arg1: bool, arg2: u64, arg3: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg4: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg5: 0x2::balance::Balance<T0>) : (DecreasePositionOrder<T0>, CreateDecreasePositionOrderEvent) {
        let v0 = CreateDecreasePositionOrderEvent{
            take_profit                : arg1,
            decrease_amount            : arg2,
            limited_index_price        : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(&arg3),
            collateral_price_threshold : arg4,
            fee_amount                 : 0x2::balance::value<T0>(&arg5),
        };
        let v1 = DecreasePositionOrder<T0>{
            executed                   : false,
            created_at                 : arg0,
            take_profit                : arg1,
            decrease_amount            : arg2,
            limited_index_price        : arg3,
            collateral_price_threshold : arg4,
            fee                        : arg5,
        };
        (v1, v0)
    }

    public(friend) fun new_decrease_position_order_v1_1<T0>(arg0: u64, arg1: bool, arg2: u64, arg3: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg4: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg5: 0x2::balance::Balance<T0>) : (DecreasePositionOrderV1_1<T0>, CreateDecreasePositionOrderEvent) {
        let v0 = CreateDecreasePositionOrderEvent{
            take_profit                : arg1,
            decrease_amount            : arg2,
            limited_index_price        : arg3,
            collateral_price_threshold : arg4,
            fee_amount                 : 0x2::balance::value<T0>(&arg5),
        };
        let v1 = DecreasePositionOrderV1_1<T0>{
            executed                   : false,
            created_at                 : arg0,
            take_profit                : arg1,
            decrease_amount            : arg2,
            limited_index_price        : arg3,
            collateral_price_threshold : arg4,
            fee                        : arg5,
        };
        (v1, v0)
    }

    public(friend) fun new_decrease_position_order_v2<T0>(arg0: u64, arg1: bool, arg2: u64, arg3: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg4: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg5: 0x2::balance::Balance<T0>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate>, arg8: address) : (DecreasePositionOrderV2<T0>, CreateDecreasePositionOrderV2Event) {
        let v0 = CreateDecreasePositionOrderV2Event{
            take_profit                : arg1,
            decrease_amount            : arg2,
            limited_index_price        : arg3,
            collateral_price_threshold : arg4,
            fee_amount                 : 0x2::balance::value<T0>(&arg5),
            scard_id                   : arg6,
            scard_rebate_rate          : arg7,
        };
        let v1 = DecreasePositionOrderV2<T0>{
            executed                   : false,
            created_at                 : arg0,
            take_profit                : arg1,
            decrease_amount            : arg2,
            limited_index_price        : arg3,
            collateral_price_threshold : arg4,
            fee                        : arg5,
            scard_id                   : arg6,
            scard_rebate_rate          : arg7,
            referrer                   : arg8,
        };
        (v1, v0)
    }

    public(friend) fun new_open_position_order<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg4: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg5: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::PositionConfig, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>) : (OpenPositionOrder<T0, T1>, CreateOpenPositionOrderEvent) {
        let v0 = CreateOpenPositionOrderEvent{
            open_amount                : arg1,
            reserve_amount             : arg2,
            limited_index_price        : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(&arg3),
            collateral_price_threshold : arg4,
            position_config            : arg5,
            collateral_amount          : 0x2::balance::value<T0>(&arg6),
            fee_amount                 : 0x2::balance::value<T1>(&arg7),
        };
        let v1 = OpenPositionOrder<T0, T1>{
            executed                   : false,
            created_at                 : arg0,
            open_amount                : arg1,
            reserve_amount             : arg2,
            limited_index_price        : arg3,
            collateral_price_threshold : arg4,
            position_config            : arg5,
            collateral                 : arg6,
            fee                        : arg7,
        };
        (v1, v0)
    }

    public(friend) fun new_open_position_order_v1_1<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg4: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg5: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::PositionConfig, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>) : (OpenPositionOrderV1_1<T0, T1>, CreateOpenPositionOrderEvent) {
        let v0 = CreateOpenPositionOrderEvent{
            open_amount                : arg1,
            reserve_amount             : arg2,
            limited_index_price        : arg3,
            collateral_price_threshold : arg4,
            position_config            : arg5,
            collateral_amount          : 0x2::balance::value<T0>(&arg6),
            fee_amount                 : 0x2::balance::value<T1>(&arg7),
        };
        let v1 = OpenPositionOrderV1_1<T0, T1>{
            executed                   : false,
            created_at                 : arg0,
            open_amount                : arg1,
            reserve_amount             : arg2,
            limited_index_price        : arg3,
            collateral_price_threshold : arg4,
            position_config            : arg5,
            collateral                 : arg6,
            fee                        : arg7,
        };
        (v1, v0)
    }

    public(friend) fun new_open_position_order_v2<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg4: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg5: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::PositionConfig, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: 0x1::option::Option<0x2::object::ID>, arg9: 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate>, arg10: address) : (OpenPositionOrderV2<T0, T1>, CreateOpenPositionOrderV2Event) {
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<T1>(), 303);
        let v0 = CreateOpenPositionOrderV2Event{
            open_amount                : arg1,
            reserve_amount             : arg2,
            limited_index_price        : arg3,
            collateral_price_threshold : arg4,
            position_config            : arg5,
            collateral_amount          : 0x2::balance::value<T0>(&arg6),
            fee_amount                 : 0x2::balance::value<T1>(&arg7),
            scard_id                   : arg8,
            scard_rebate_rate          : arg9,
        };
        let v1 = OpenPositionOrderV2<T0, T1>{
            executed                   : false,
            created_at                 : arg0,
            open_amount                : arg1,
            reserve_amount             : arg2,
            limited_index_price        : arg3,
            collateral_price_threshold : arg4,
            position_config            : arg5,
            collateral                 : arg6,
            fee                        : arg7,
            scard_id                   : arg8,
            scard_rebate_rate          : arg9,
            referrer                   : arg10,
        };
        (v1, v0)
    }

    // decompiled from Move bytecode v6
}

