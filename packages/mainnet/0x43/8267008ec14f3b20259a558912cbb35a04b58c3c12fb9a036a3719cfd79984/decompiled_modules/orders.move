module 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::orders {
    struct OpenPositionOrder<phantom T0, phantom T1> has store {
        executed: bool,
        created_at: u64,
        open_amount: u64,
        reserve_amount: u64,
        limited_index_price: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        collateral_price_threshold: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        position_config: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::PositionConfig,
        collateral: 0x2::balance::Balance<T0>,
        fee: 0x2::balance::Balance<T1>,
        scard_id: 0x1::option::Option<0x2::object::ID>,
        scard_rebate_rate: 0x1::option::Option<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate>,
        referrer: address,
    }

    struct DecreasePositionOrder<phantom T0> has store {
        executed: bool,
        created_at: u64,
        take_profit: bool,
        decrease_amount: u64,
        limited_index_price: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        collateral_price_threshold: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        fee: 0x2::balance::Balance<T0>,
        scard_id: 0x1::option::Option<0x2::object::ID>,
        scard_rebate_rate: 0x1::option::Option<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate>,
        referrer: address,
    }

    struct CreateOpenPositionOrderEvent has copy, drop {
        open_amount: u64,
        reserve_amount: u64,
        limited_index_price: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        collateral_price_threshold: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        position_config: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::PositionConfig,
        collateral_amount: u64,
        fee_amount: u64,
        scard_id: 0x1::option::Option<0x2::object::ID>,
        scard_rebate_rate: 0x1::option::Option<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate>,
    }

    struct CreateDecreasePositionOrderEvent has copy, drop {
        take_profit: bool,
        decrease_amount: u64,
        limited_index_price: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        collateral_price_threshold: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        fee_amount: u64,
        scard_id: 0x1::option::Option<0x2::object::ID>,
        scard_rebate_rate: 0x1::option::Option<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate>,
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
            scard_id                   : _,
            scard_rebate_rate          : _,
            referrer                   : _,
        } = arg0;
        (v7, v8)
    }

    public(friend) fun execute_decrease_position_order<T0, T1>(arg0: &mut DecreasePositionOrder<T1>, arg1: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::Vault<T0>, arg2: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::Symbol, arg3: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::fee::FeeConfig, arg4: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::Position<T0>, arg5: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel, arg6: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::FundingFeeModel, arg7: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg8: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg9: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate, arg10: bool, arg11: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg12: u64) : (0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::DecreasePositionResult<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg10 && arg0.take_profit || !arg10 && !arg0.take_profit) {
            let v0 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg8);
            assert!(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::ge(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg8);
            assert!(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::le(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        let v2 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::from_price(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::symbol_price_config(arg2), arg0.limited_index_price);
        (0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::decrease_position<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v2, arg0.collateral_price_threshold, arg9, arg0.scard_rebate_rate, arg10, arg0.decrease_amount, arg11, arg12, arg0.referrer), 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_decrease_position_order_v1<T0, T1>(arg0: &mut DecreasePositionOrder<T1>, arg1: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::Vault<T0>, arg2: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::Symbol, arg3: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::fee::FeeConfig, arg4: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::Position<T0>, arg5: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel, arg6: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::FundingFeeModel, arg7: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg8: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg9: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate, arg10: bool, arg11: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg12: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::PositionInstantExitFeeConfig, arg13: u64) : (0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::DecreasePositionResultV1<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg10 && arg0.take_profit || !arg10 && !arg0.take_profit) {
            let v0 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg8);
            assert!(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::ge(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg8);
            assert!(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::le(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        let v2 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::from_price(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::symbol_price_config(arg2), arg0.limited_index_price);
        (0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::decrease_position_v1<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v2, arg0.collateral_price_threshold, arg9, arg0.scard_rebate_rate, arg10, arg0.decrease_amount, arg11, arg12, arg13, arg0.referrer), 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_decrease_position_order_v1_1<T0, T1>(arg0: &mut DecreasePositionOrder<T1>, arg1: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::Vault<T0>, arg2: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::Symbol, arg3: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::fee::FeeConfig, arg4: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::Position<T0>, arg5: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel, arg6: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::FundingFeeModel, arg7: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg8: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg9: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate, arg10: bool, arg11: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg12: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::PositionInstantExitFeeConfig, arg13: u64, arg14: bool) : (0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::DecreasePositionResultV1<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg10 && arg0.take_profit || !arg10 && !arg0.take_profit) {
            let v0 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg8);
            assert!(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::ge(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg8);
            assert!(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::le(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        let v2 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::from_price(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::symbol_price_config(arg2), arg0.limited_index_price);
        (0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::decrease_position_v1_1<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v2, arg0.collateral_price_threshold, arg9, arg0.scard_rebate_rate, arg10, arg0.decrease_amount, arg11, arg12, arg13, arg0.referrer, arg14), 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_open_position_order<T0, T1>(arg0: &mut OpenPositionOrder<T0, T1>, arg1: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::Vault<T0>, arg2: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::Symbol, arg3: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::fee::FeeConfig, arg4: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel, arg5: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::FundingFeeModel, arg6: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg7: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg8: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate, arg9: bool, arg10: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg11: u64) : (0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::OpenPositionResult<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg9) {
            let v0 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg7);
            assert!(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::le(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg7);
            assert!(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::ge(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        let v2 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::from_price(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::symbol_price_config(arg2), arg0.limited_index_price);
        (0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::open_position<T0>(arg1, arg2, arg3, arg4, arg5, &arg0.position_config, arg6, &v2, &mut arg0.collateral, arg0.collateral_price_threshold, arg8, arg0.scard_rebate_rate, arg9, arg0.open_amount, arg0.reserve_amount, arg10, arg11, arg0.referrer), 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_open_position_order_v1<T0, T1>(arg0: &mut OpenPositionOrder<T0, T1>, arg1: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::Vault<T0>, arg2: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::Symbol, arg3: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::fee::FeeConfig, arg4: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel, arg5: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::FundingFeeModel, arg6: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg7: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg8: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate, arg9: bool, arg10: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg11: u64, arg12: bool) : (0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::OpenPositionResult<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg9) {
            let v0 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg7);
            assert!(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::le(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg7);
            assert!(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::ge(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        let v2 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::from_price(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::symbol_price_config(arg2), arg0.limited_index_price);
        (0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool::open_position_v1<T0>(arg1, arg2, arg3, arg4, arg5, &arg0.position_config, arg6, &v2, &mut arg0.collateral, arg0.collateral_price_threshold, arg8, arg0.scard_rebate_rate, arg9, arg0.open_amount, arg0.reserve_amount, arg10, arg11, arg0.referrer, arg12), 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun get_scard_id_from_decrease_order<T0>(arg0: &DecreasePositionOrder<T0>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.scard_id
    }

    public(friend) fun get_scard_id_from_open_order<T0, T1>(arg0: &OpenPositionOrder<T0, T1>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.scard_id
    }

    public(friend) fun new_decrease_position_order<T0>(arg0: u64, arg1: bool, arg2: u64, arg3: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg4: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg5: 0x2::balance::Balance<T0>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: 0x1::option::Option<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate>, arg8: address) : (DecreasePositionOrder<T0>, CreateDecreasePositionOrderEvent) {
        let v0 = CreateDecreasePositionOrderEvent{
            take_profit                : arg1,
            decrease_amount            : arg2,
            limited_index_price        : arg3,
            collateral_price_threshold : arg4,
            fee_amount                 : 0x2::balance::value<T0>(&arg5),
            scard_id                   : arg6,
            scard_rebate_rate          : arg7,
        };
        let v1 = DecreasePositionOrder<T0>{
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

    public(friend) fun new_open_position_order<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg4: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg5: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::PositionConfig, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: 0x1::option::Option<0x2::object::ID>, arg9: 0x1::option::Option<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate>, arg10: address) : (OpenPositionOrder<T0, T1>, CreateOpenPositionOrderEvent) {
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<T1>(), 303);
        let v0 = CreateOpenPositionOrderEvent{
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
            scard_id                   : arg8,
            scard_rebate_rate          : arg9,
            referrer                   : arg10,
        };
        (v1, v0)
    }

    // decompiled from Move bytecode v6
}

