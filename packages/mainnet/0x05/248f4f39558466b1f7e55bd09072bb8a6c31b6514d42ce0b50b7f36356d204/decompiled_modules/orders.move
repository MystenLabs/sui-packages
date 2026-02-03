module 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders {
    struct OpenPositionOrder<phantom T0, phantom T1> has store {
        executed: bool,
        created_at: u64,
        open_amount: u64,
        reserve_amount: u64,
        limited_index_price: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        collateral_price_threshold: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        position_config: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::PositionConfig,
        collateral: 0x2::balance::Balance<T0>,
        fee: 0x2::balance::Balance<T1>,
        scard_id: 0x1::option::Option<0x2::object::ID>,
        scard_rebate_rate: 0x1::option::Option<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>,
        referrer: address,
    }

    struct OpenMarketOrder<phantom T0, phantom T1> has store {
        executed: bool,
        created_at: u64,
        open_amount: u64,
        reserve_amount: u64,
        index_price: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        index_price_threshold: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        collateral_price_threshold: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        position_config: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::PositionConfig,
        collateral: 0x2::balance::Balance<T0>,
        fee: 0x2::balance::Balance<T1>,
        scard_id: 0x1::option::Option<0x2::object::ID>,
        scard_rebate_rate: 0x1::option::Option<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>,
        referrer: address,
    }

    struct DecreasePositionOrder<phantom T0> has store {
        executed: bool,
        created_at: u64,
        take_profit: bool,
        decrease_amount: u64,
        limited_index_price: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        collateral_price_threshold: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        fee: 0x2::balance::Balance<T0>,
        scard_id: 0x1::option::Option<0x2::object::ID>,
        scard_rebate_rate: 0x1::option::Option<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>,
        referrer: address,
    }

    struct DecreaseMarketOrder<phantom T0> has store {
        executed: bool,
        created_at: u64,
        take_profit: bool,
        decrease_amount: u64,
        limited_index_price: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        index_price_threshold: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        collateral_price_threshold: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        fee: 0x2::balance::Balance<T0>,
        scard_id: 0x1::option::Option<0x2::object::ID>,
        scard_rebate_rate: 0x1::option::Option<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>,
        referrer: address,
    }

    struct CreateOpenPositionOrderEvent has copy, drop {
        open_amount: u64,
        reserve_amount: u64,
        limited_index_price: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        collateral_price_threshold: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        position_config: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::PositionConfig,
        collateral_amount: u64,
        fee_amount: u64,
        scard_id: 0x1::option::Option<0x2::object::ID>,
        scard_rebate_rate: 0x1::option::Option<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>,
    }

    struct CreateOpenMarketOrderEvent has copy, drop {
        open_amount: u64,
        reserve_amount: u64,
        index_price: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        index_price_threshold: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        collateral_price_threshold: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        position_config: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::PositionConfig,
        collateral_amount: u64,
        fee_amount: u64,
        scard_id: 0x1::option::Option<0x2::object::ID>,
        scard_rebate_rate: 0x1::option::Option<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>,
    }

    struct CreateDecreasePositionOrderEvent has copy, drop {
        take_profit: bool,
        decrease_amount: u64,
        limited_index_price: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        collateral_price_threshold: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        fee_amount: u64,
        scard_id: 0x1::option::Option<0x2::object::ID>,
        scard_rebate_rate: 0x1::option::Option<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>,
    }

    struct CreateDecreaseMarketOrderEvent has copy, drop {
        take_profit: bool,
        decrease_amount: u64,
        limited_index_price: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        index_price_threshold: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        collateral_price_threshold: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        fee_amount: u64,
        scard_id: 0x1::option::Option<0x2::object::ID>,
        scard_rebate_rate: 0x1::option::Option<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>,
    }

    public(friend) fun destroy_decrease_market_order<T0>(arg0: DecreaseMarketOrder<T0>) : 0x2::balance::Balance<T0> {
        let DecreaseMarketOrder {
            executed                   : _,
            created_at                 : _,
            take_profit                : _,
            decrease_amount            : _,
            limited_index_price        : _,
            index_price_threshold      : _,
            collateral_price_threshold : _,
            fee                        : v7,
            scard_id                   : _,
            scard_rebate_rate          : _,
            referrer                   : _,
        } = arg0;
        v7
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

    public(friend) fun destroy_open_market_order<T0, T1>(arg0: OpenMarketOrder<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let OpenMarketOrder {
            executed                   : _,
            created_at                 : _,
            open_amount                : _,
            reserve_amount             : _,
            index_price                : _,
            index_price_threshold      : _,
            collateral_price_threshold : _,
            position_config            : _,
            collateral                 : v8,
            fee                        : v9,
            scard_id                   : _,
            scard_rebate_rate          : _,
            referrer                   : _,
        } = arg0;
        (v8, v9)
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

    public(friend) fun execute_decrease_market_order<T0, T1>(arg0: &mut DecreaseMarketOrder<T1>, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T0>, arg2: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::FeeConfig, arg4: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T0>, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg8: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg9: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg10: bool, arg11: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg12: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::PositionInstantExitFeeConfig, arg13: u64, arg14: bool) : (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::DecreasePositionResultV1<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        let v0 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::diff(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(arg8), arg0.limited_index_price);
        assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::le(&v0, &arg0.index_price_threshold), 304);
        arg0.executed = true;
        (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::decrease_position_v1_1<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg0.collateral_price_threshold, arg9, arg0.scard_rebate_rate, arg10, arg0.decrease_amount, arg11, arg12, arg13, arg0.referrer, arg14), 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_decrease_market_order_with_loss_protection<T0, T1>(arg0: &mut DecreaseMarketOrder<T1>, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T0>, arg2: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol, arg3: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg4: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T0>, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg8: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg9: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg10: bool, arg11: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg12: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::PositionInstantExitFeeConfig, arg13: u64, arg14: bool, arg15: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::LossProtectionVault<T0>, arg16: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate) : (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::DecreasePositionResultV1<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        let v0 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::diff(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(arg8), arg0.limited_index_price);
        assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::le(&v0, &arg0.index_price_threshold), 304);
        arg0.executed = true;
        let v1 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::from_price(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_price_config(arg2), arg0.limited_index_price);
        (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::decrease_position_v1_1_with_loss_protection<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v1, arg0.collateral_price_threshold, arg9, arg0.scard_rebate_rate, arg10, arg0.decrease_amount, arg11, arg12, arg13, arg0.referrer, arg14, arg15, arg16), 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_decrease_position_order<T0, T1>(arg0: &mut DecreasePositionOrder<T1>, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T0>, arg2: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::FeeConfig, arg4: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T0>, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg8: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg9: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg10: bool, arg11: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg12: u64) : (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::DecreasePositionResult<T0>, 0x2::balance::Balance<T1>) {
        abort 0
    }

    public(friend) fun execute_decrease_position_order_v1<T0, T1>(arg0: &mut DecreasePositionOrder<T1>, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T0>, arg2: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::FeeConfig, arg4: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T0>, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg8: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg9: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg10: bool, arg11: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg12: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::PositionInstantExitFeeConfig, arg13: u64) : (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::DecreasePositionResultV1<T0>, 0x2::balance::Balance<T1>) {
        abort 0
    }

    public(friend) fun execute_decrease_position_order_v1_1<T0, T1>(arg0: &mut DecreasePositionOrder<T1>, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T0>, arg2: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::FeeConfig, arg4: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T0>, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg8: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg9: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg10: bool, arg11: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg12: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::PositionInstantExitFeeConfig, arg13: u64, arg14: bool) : (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::DecreasePositionResultV1<T0>, 0x2::balance::Balance<T1>) {
        abort 0
    }

    public(friend) fun execute_decrease_position_order_v1_1_with_loss_protection<T0, T1>(arg0: &mut DecreasePositionOrder<T1>, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T0>, arg2: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol, arg3: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg4: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T0>, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg8: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg9: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg10: bool, arg11: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg12: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::PositionInstantExitFeeConfig, arg13: u64, arg14: bool, arg15: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::LossProtectionVault<T0>, arg16: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate) : (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::DecreasePositionResultV1<T0>, 0x2::balance::Balance<T1>) {
        abort 0
    }

    public(friend) fun execute_decrease_position_order_v2<T0, T1>(arg0: &mut DecreasePositionOrder<T1>, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T0>, arg2: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::FeeConfig, arg4: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T0>, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg8: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg9: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg10: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg11: bool, arg12: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg13: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::PositionInstantExitFeeConfig, arg14: u64, arg15: bool) : (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::DecreasePositionResultV1<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg11 && arg0.take_profit || !arg11 && !arg0.take_profit) {
            let v0 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(arg8);
            assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::ge(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(arg8);
            assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::le(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::decrease_position_v1_1<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg0.collateral_price_threshold, arg10, arg0.scard_rebate_rate, arg11, arg0.decrease_amount, arg12, arg13, arg14, arg0.referrer, arg15), 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_decrease_position_order_v2_with_loss_protection<T0, T1>(arg0: &mut DecreasePositionOrder<T1>, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T0>, arg2: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol, arg3: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg4: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T0>, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg8: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg9: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg10: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg11: bool, arg12: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg13: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::PositionInstantExitFeeConfig, arg14: u64, arg15: bool, arg16: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::LossProtectionVault<T0>, arg17: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate) : (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::DecreasePositionResultV1<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg11 && arg0.take_profit || !arg11 && !arg0.take_profit) {
            let v0 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(arg8);
            assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::ge(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(arg8);
            assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::le(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::decrease_position_v1_1_with_loss_protection<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg0.collateral_price_threshold, arg10, arg0.scard_rebate_rate, arg11, arg0.decrease_amount, arg12, arg13, arg14, arg0.referrer, arg15, arg16, arg17), 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_open_market_order<T0, T1>(arg0: &mut OpenMarketOrder<T0, T1>, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T0>, arg2: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::FeeConfig, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg8: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg9: bool, arg10: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg11: u64, arg12: bool) : (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::OpenPositionResult<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        let v0 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::diff(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(arg7), arg0.index_price);
        assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::le(&v0, &arg0.index_price_threshold), 304);
        arg0.executed = true;
        (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::open_position_v1<T0>(arg1, arg2, arg3, arg4, arg5, &arg0.position_config, arg6, arg7, &mut arg0.collateral, arg0.collateral_price_threshold, arg8, arg0.scard_rebate_rate, arg9, arg0.open_amount, arg0.reserve_amount, arg10, arg11, arg0.referrer, arg12), 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun execute_open_position_order<T0, T1>(arg0: &mut OpenPositionOrder<T0, T1>, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T0>, arg2: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::FeeConfig, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg8: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg9: bool, arg10: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg11: u64) : (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::OpenPositionResult<T0>, 0x2::balance::Balance<T1>) {
        abort 0
    }

    public(friend) fun execute_open_position_order_v1<T0, T1>(arg0: &mut OpenPositionOrder<T0, T1>, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T0>, arg2: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::FeeConfig, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg8: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg9: bool, arg10: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg11: u64, arg12: bool) : (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::OpenPositionResult<T0>, 0x2::balance::Balance<T1>) {
        abort 0
    }

    public(friend) fun execute_open_position_order_v2<T0, T1>(arg0: &mut OpenPositionOrder<T0, T1>, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T0>, arg2: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::FeeConfig, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg8: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice, arg9: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg10: bool, arg11: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg12: u64, arg13: bool) : (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::OpenPositionResult<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.executed, 301);
        if (arg10) {
            let v0 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(arg7);
            assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::le(&v0, &arg0.limited_index_price), 302);
        } else {
            let v1 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(arg7);
            assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::ge(&v1, &arg0.limited_index_price), 302);
        };
        arg0.executed = true;
        (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::open_position_v1<T0>(arg1, arg2, arg3, arg4, arg5, &arg0.position_config, arg6, arg8, &mut arg0.collateral, arg0.collateral_price_threshold, arg9, arg0.scard_rebate_rate, arg10, arg0.open_amount, arg0.reserve_amount, arg11, arg12, arg0.referrer, arg13), 0x2::balance::withdraw_all<T1>(&mut arg0.fee))
    }

    public(friend) fun get_decrease_amount<T0>(arg0: &DecreasePositionOrder<T0>) : u64 {
        arg0.decrease_amount
    }

    public(friend) fun get_decrease_amount_market_order<T0>(arg0: &DecreaseMarketOrder<T0>) : u64 {
        arg0.decrease_amount
    }

    public(friend) fun get_open_amount<T0, T1>(arg0: &OpenPositionOrder<T0, T1>) : u64 {
        arg0.open_amount
    }

    public(friend) fun get_open_amount_market_order<T0, T1>(arg0: &OpenMarketOrder<T0, T1>) : u64 {
        arg0.open_amount
    }

    public(friend) fun get_scard_id_from_decrease_market_order<T0>(arg0: &DecreaseMarketOrder<T0>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.scard_id
    }

    public(friend) fun get_scard_id_from_decrease_order<T0>(arg0: &DecreasePositionOrder<T0>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.scard_id
    }

    public(friend) fun get_scard_id_from_open_market_order<T0, T1>(arg0: &OpenMarketOrder<T0, T1>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.scard_id
    }

    public(friend) fun get_scard_id_from_open_order<T0, T1>(arg0: &OpenPositionOrder<T0, T1>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.scard_id
    }

    public(friend) fun new_decrease_market_order<T0>(arg0: u64, arg1: bool, arg2: u64, arg3: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg4: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg5: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg6: 0x2::balance::Balance<T0>, arg7: 0x1::option::Option<0x2::object::ID>, arg8: 0x1::option::Option<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>, arg9: address) : (DecreaseMarketOrder<T0>, CreateDecreaseMarketOrderEvent) {
        let v0 = CreateDecreaseMarketOrderEvent{
            take_profit                : arg1,
            decrease_amount            : arg2,
            limited_index_price        : arg3,
            index_price_threshold      : arg4,
            collateral_price_threshold : arg5,
            fee_amount                 : 0x2::balance::value<T0>(&arg6),
            scard_id                   : arg7,
            scard_rebate_rate          : arg8,
        };
        let v1 = DecreaseMarketOrder<T0>{
            executed                   : false,
            created_at                 : arg0,
            take_profit                : arg1,
            decrease_amount            : arg2,
            limited_index_price        : arg3,
            index_price_threshold      : arg4,
            collateral_price_threshold : arg5,
            fee                        : arg6,
            scard_id                   : arg7,
            scard_rebate_rate          : arg8,
            referrer                   : arg9,
        };
        (v1, v0)
    }

    public(friend) fun new_decrease_position_order<T0>(arg0: u64, arg1: bool, arg2: u64, arg3: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg4: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg5: 0x2::balance::Balance<T0>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: 0x1::option::Option<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>, arg8: address) : (DecreasePositionOrder<T0>, CreateDecreasePositionOrderEvent) {
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

    public(friend) fun new_open_market_order<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg4: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg5: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg6: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::PositionConfig, arg7: 0x2::balance::Balance<T0>, arg8: 0x2::balance::Balance<T1>, arg9: 0x1::option::Option<0x2::object::ID>, arg10: 0x1::option::Option<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>, arg11: address) : (OpenMarketOrder<T0, T1>, CreateOpenMarketOrderEvent) {
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<T1>(), 303);
        let v0 = CreateOpenMarketOrderEvent{
            open_amount                : arg1,
            reserve_amount             : arg2,
            index_price                : arg3,
            index_price_threshold      : arg4,
            collateral_price_threshold : arg5,
            position_config            : arg6,
            collateral_amount          : 0x2::balance::value<T0>(&arg7),
            fee_amount                 : 0x2::balance::value<T1>(&arg8),
            scard_id                   : arg9,
            scard_rebate_rate          : arg10,
        };
        let v1 = OpenMarketOrder<T0, T1>{
            executed                   : false,
            created_at                 : arg0,
            open_amount                : arg1,
            reserve_amount             : arg2,
            index_price                : arg3,
            index_price_threshold      : arg4,
            collateral_price_threshold : arg5,
            position_config            : arg6,
            collateral                 : arg7,
            fee                        : arg8,
            scard_id                   : arg9,
            scard_rebate_rate          : arg10,
            referrer                   : arg11,
        };
        (v1, v0)
    }

    public(friend) fun new_open_position_order<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg4: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg5: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::PositionConfig, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: 0x1::option::Option<0x2::object::ID>, arg9: 0x1::option::Option<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>, arg10: address) : (OpenPositionOrder<T0, T1>, CreateOpenPositionOrderEvent) {
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

