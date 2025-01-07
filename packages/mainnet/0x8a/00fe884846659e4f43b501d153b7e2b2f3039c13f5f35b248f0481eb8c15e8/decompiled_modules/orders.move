module 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::orders {
    struct OpenPositionOrder<phantom T0, phantom T1> has store {
        executed: bool,
        created_at: u64,
        open_amount: u64,
        reserve_amount: u64,
        limited_index_price: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::AggPrice,
        collateral_price_threshold: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::Decimal,
        position_config: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::position::PositionConfig,
        collateral: 0x2::balance::Balance<T0>,
        fee: 0x2::balance::Balance<T1>,
    }

    struct DecreasePositionOrder<phantom T0> has store {
        executed: bool,
        created_at: u64,
        take_profit: bool,
        decrease_amount: u64,
        limited_index_price: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::AggPrice,
        collateral_price_threshold: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::Decimal,
        fee: 0x2::balance::Balance<T0>,
    }

    struct CreateOpenPositionOrderEvent has copy, drop {
        open_amount: u64,
        reserve_amount: u64,
        limited_index_price: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::Decimal,
        collateral_price_threshold: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::Decimal,
        position_config: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::position::PositionConfig,
        collateral_amount: u64,
        fee_amount: u64,
    }

    struct CreateDecreasePositionOrderEvent has copy, drop {
        take_profit: bool,
        decrease_amount: u64,
        limited_index_price: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::Decimal,
        collateral_price_threshold: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::Decimal,
        fee_amount: u64,
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

    public(friend) fun execute_decrease_position_order<T0, T1>(arg0: &mut DecreasePositionOrder<T1>, arg1: &mut 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::pool::Vault<T0>, arg2: &mut 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::pool::Symbol, arg3: &mut 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::position::Position<T0>, arg4: &0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::model::ReservingFeeModel, arg5: &0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::model::FundingFeeModel, arg6: &0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::AggPrice, arg7: &0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::AggPrice, arg8: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::Rate, arg9: bool, arg10: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::Decimal, arg11: u64) : (u64, 0x1::option::Option<0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::pool::DecreasePositionResult<T0>>, 0x1::option::Option<0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::pool::DecreasePositionFailedEvent>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 1);
        if (arg9 && arg0.take_profit || !arg9 && !arg0.take_profit) {
            let v0 = 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::price_of(arg7);
            let v1 = 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::price_of(&arg0.limited_index_price);
            assert!(0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::ge(&v0, &v1), 2);
        } else {
            let v2 = 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::price_of(arg7);
            let v3 = 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::price_of(&arg0.limited_index_price);
            assert!(0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::le(&v2, &v3), 2);
        };
        arg0.executed = true;
        let (v4, v5, v6) = 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::pool::decrease_position<T0>(arg1, arg2, arg3, arg4, arg5, arg6, &arg0.limited_index_price, arg0.collateral_price_threshold, arg8, arg9, arg0.decrease_amount, arg10, arg11);
        (v4, v5, v6, 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_open_position_order<T0, T1>(arg0: &mut OpenPositionOrder<T0, T1>, arg1: &mut 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::pool::Vault<T0>, arg2: &mut 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::pool::Symbol, arg3: &0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::model::ReservingFeeModel, arg4: &0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::model::FundingFeeModel, arg5: &0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::AggPrice, arg6: &0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::AggPrice, arg7: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::Rate, arg8: bool, arg9: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::Decimal, arg10: u64) : (u64, 0x1::option::Option<0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::pool::OpenPositionResult<T0>>, 0x1::option::Option<0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::pool::OpenPositionFailedEvent>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 1);
        if (arg8) {
            let v0 = 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::price_of(arg6);
            let v1 = 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::price_of(&arg0.limited_index_price);
            assert!(0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::le(&v0, &v1), 2);
        } else {
            let v2 = 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::price_of(arg6);
            let v3 = 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::price_of(&arg0.limited_index_price);
            assert!(0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::ge(&v2, &v3), 2);
        };
        arg0.executed = true;
        let (v4, v5, v6) = 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::pool::open_position<T0>(arg1, arg2, arg3, arg4, &arg0.position_config, arg5, &arg0.limited_index_price, &mut arg0.collateral, arg0.collateral_price_threshold, arg7, arg8, arg0.open_amount, arg0.reserve_amount, arg9, arg10);
        (v4, v5, v6, 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun new_decrease_position_order<T0>(arg0: u64, arg1: bool, arg2: u64, arg3: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::AggPrice, arg4: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::Decimal, arg5: 0x2::balance::Balance<T0>) : (DecreasePositionOrder<T0>, CreateDecreasePositionOrderEvent) {
        let v0 = CreateDecreasePositionOrderEvent{
            take_profit                : arg1,
            decrease_amount            : arg2,
            limited_index_price        : 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::price_of(&arg3),
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

    public(friend) fun new_open_position_order<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::AggPrice, arg4: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::Decimal, arg5: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::position::PositionConfig, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>) : (OpenPositionOrder<T0, T1>, CreateOpenPositionOrderEvent) {
        let v0 = CreateOpenPositionOrderEvent{
            open_amount                : arg1,
            reserve_amount             : arg2,
            limited_index_price        : 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::agg_price::price_of(&arg3),
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

    // decompiled from Move bytecode v6
}

