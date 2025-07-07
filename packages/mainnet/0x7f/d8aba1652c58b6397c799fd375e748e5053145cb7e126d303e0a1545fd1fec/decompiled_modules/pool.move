module 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::pool {
    struct Vault<phantom T0> has store {
        enabled: bool,
        weight: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        reserving_fee_model: 0x2::object::ID,
        price_config: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPriceConfig,
        last_update: u64,
        liquidity: 0x2::balance::Balance<T0>,
        reserved_amount: u64,
        unrealised_reserving_fee_amount: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        acc_reserving_rate: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate,
    }

    struct Symbol has store {
        open_enabled: bool,
        decrease_enabled: bool,
        liquidate_enabled: bool,
        supported_collaterals: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        funding_fee_model: 0x2::object::ID,
        price_config: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPriceConfig,
        last_update: u64,
        opening_amount: u64,
        opening_size: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        realised_pnl: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::SDecimal,
        unrealised_funding_fee_value: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::SDecimal,
        acc_funding_rate: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::srate::SRate,
    }

    struct OpenPositionResult<phantom T0> {
        position: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::Position<T0>,
        referral_rebate: 0x2::balance::Balance<T0>,
        fee_rebate: 0x2::balance::Balance<T0>,
        scard_rebate: 0x1::option::Option<0x2::balance::Balance<T0>>,
        event: OpenPositionSuccessEvent,
    }

    struct DecreasePositionResult<phantom T0> {
        to_trader: 0x2::balance::Balance<T0>,
        referral_rebate: 0x2::balance::Balance<T0>,
        fee_rebate: 0x2::balance::Balance<T0>,
        scard_rebate: 0x1::option::Option<0x2::balance::Balance<T0>>,
        event: DecreasePositionSuccessEvent,
    }

    struct OpenPositionSuccessEvent has copy, drop {
        position_config: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::PositionConfig,
        collateral_price: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        index_price: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        open_amount: u64,
        open_fee_amount: u64,
        reserve_amount: u64,
        collateral_amount: u64,
        referral_rebate_amount: u64,
        fee_rebate_amount: u64,
        scard_rebate_amount: 0x1::option::Option<u64>,
        referrer: address,
    }

    struct DecreasePositionSuccessEvent has copy, drop {
        collateral_price: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        index_price: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        decrease_amount: u64,
        decrease_fee_value: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        reserving_fee_value: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        funding_fee_value: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::SDecimal,
        delta_realised_pnl: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::SDecimal,
        closed: bool,
        has_profit: bool,
        settled_amount: u64,
        referral_rebate_amount: u64,
        fee_rebate_amount: u64,
        scard_rebate_amount: 0x1::option::Option<u64>,
        referrer: address,
    }

    struct DecreaseReservedFromPositionEvent has copy, drop {
        decrease_amount: u64,
    }

    struct PledgeInPositionEvent has copy, drop {
        pledge_amount: u64,
    }

    struct RedeemFromPositionEvent has copy, drop {
        collateral_price: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        index_price: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        redeem_amount: u64,
    }

    struct LiquidatePositionEvent has copy, drop {
        liquidator: address,
        collateral_price: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        index_price: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        position_size: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        reserving_fee_value: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal,
        funding_fee_value: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::SDecimal,
        delta_realised_pnl: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::SDecimal,
        loss_amount: u64,
        liquidator_bonus_amount: u64,
        liquidation_amount: u64,
    }

    public fun compute_rebase_fee_rate(arg0: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::RebaseFeeModel, arg1: bool, arg2: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg3: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg4: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg5: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal) : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate {
        if (0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::eq(&arg2, &arg3)) {
            0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::zero()
        } else {
            0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::compute_rebase_fee_rate(arg0, arg1, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::to_rate(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::div(arg2, arg3)), 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::to_rate(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::div(arg4, arg5)))
        }
    }

    public(friend) fun add_collateral_to_symbol<T0>(arg0: &mut Symbol) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.supported_collaterals, 0x1::type_name::get<T0>());
    }

    public(friend) fun decrease_position<T0>(arg0: &mut Vault<T0>, arg1: &mut Symbol, arg2: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::fee::FeeConfig, arg3: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::Position<T0>, arg4: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel, arg5: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::FundingFeeModel, arg6: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg7: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg8: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg9: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate, arg10: 0x1::option::Option<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate>, arg11: bool, arg12: u64, arg13: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg14: u64, arg15: address) : DecreasePositionResult<T0> {
        assert!(arg0.enabled, 100);
        assert!(arg1.decrease_enabled, 105);
        assert!(0x2::object::id<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel>(arg4) == arg0.reserving_fee_model, 112);
        assert!(0x2::object::id<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::FundingFeeModel>(arg5) == arg1.funding_fee_model, 113);
        refresh_vault<T0>(arg0, arg4, arg14);
        let v0 = symbol_delta_size(arg1, arg7, arg11);
        refresh_symbol(arg1, arg5, v0, arg13, arg14);
        let (v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::unwrap_decrease_position_result<T0>(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::decrease_position<T0>(arg3, arg6, arg7, arg8, arg11, arg12, arg0.acc_reserving_rate, arg1.acc_funding_rate, arg14));
        let v12 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::mul_with_rate(v7, arg9);
        let v13 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::floor_u64(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::value_to_coins(arg6, v12));
        let v14 = if (0x1::option::is_some<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate>(&arg10)) {
            0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::mul_with_rate(v7, *0x1::option::borrow<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate>(&arg10))
        } else {
            0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::zero()
        };
        let v15 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::floor_u64(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::value_to_coins(arg6, v14));
        let v16 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::mul_with_rate(v7, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::fee::get_fee_rate(arg2));
        let v17 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::floor_u64(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::value_to_coins(arg6, v16));
        arg0.reserved_amount = arg0.reserved_amount - v4;
        arg0.unrealised_reserving_fee_amount = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::sub(arg0.unrealised_reserving_fee_amount, v6);
        assert!(0x2::balance::join<T0>(&mut arg0.liquidity, v10) > v17 + v13 + v15, 102);
        let v18 = if (v15 > 0) {
            0x1::option::some<0x2::balance::Balance<T0>>(0x2::balance::split<T0>(&mut arg0.liquidity, v15))
        } else {
            0x1::option::none<0x2::balance::Balance<T0>>()
        };
        arg1.opening_size = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::sub(arg1.opening_size, v5);
        arg1.opening_amount = arg1.opening_amount - arg12;
        arg1.unrealised_funding_fee_value = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::sub(arg1.unrealised_funding_fee_value, v9);
        let v19 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::sub_with_decimal(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::from_decimal(!v2, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::coins_to_value(arg6, v3)), 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::add(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::sub(v7, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::add(v12, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::add(v16, v14))), v8));
        arg1.realised_pnl = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::add(arg1.realised_pnl, v19);
        let v20 = if (v15 > 0) {
            0x1::option::some<u64>(v15)
        } else {
            0x1::option::none<u64>()
        };
        let v21 = DecreasePositionSuccessEvent{
            collateral_price       : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg6),
            index_price            : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg7),
            decrease_amount        : arg12,
            decrease_fee_value     : v7,
            reserving_fee_value    : v8,
            funding_fee_value      : v9,
            delta_realised_pnl     : v19,
            closed                 : v1,
            has_profit             : v2,
            settled_amount         : v3,
            referral_rebate_amount : v13,
            fee_rebate_amount      : v17,
            scard_rebate_amount    : v20,
            referrer               : arg15,
        };
        DecreasePositionResult<T0>{
            to_trader       : v11,
            referral_rebate : 0x2::balance::split<T0>(&mut arg0.liquidity, v13),
            fee_rebate      : 0x2::balance::split<T0>(&mut arg0.liquidity, v17),
            scard_rebate    : v18,
            event           : v21,
        }
    }

    public(friend) fun decrease_reserved_from_position<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::Position<T0>, arg2: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel, arg3: u64, arg4: u64) : DecreaseReservedFromPositionEvent {
        assert!(0x2::object::id<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel>(arg2) == arg0.reserving_fee_model, 112);
        refresh_vault<T0>(arg0, arg2, arg4);
        arg0.reserved_amount = arg0.reserved_amount - arg3;
        0x2::balance::join<T0>(&mut arg0.liquidity, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::decrease_reserved_from_position<T0>(arg1, arg3, arg0.acc_reserving_rate));
        DecreaseReservedFromPositionEvent{decrease_amount: arg3}
    }

    public(friend) fun deposit<T0>(arg0: &mut Vault<T0>, arg1: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::RebaseFeeModel, arg2: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg7: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg8: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg9: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal) : (u64, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal) {
        assert!(arg0.enabled, 100);
        let v0 = 0x2::balance::value<T0>(&arg3);
        assert!(v0 > 0, 108);
        let v1 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::coins_to_value(arg2, v0);
        let v2 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::mul_with_rate(v1, compute_rebase_fee_rate(arg1, true, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::add(arg7, v1), 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::add(arg8, v1), arg0.weight, arg9));
        0x2::balance::join<T0>(&mut arg0.liquidity, arg3);
        let v3 = if (arg5 == 0) {
            assert!(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::is_zero(&arg6), 110);
            0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::truncate_decimal(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::sub(v1, v2))
        } else {
            assert!(!0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::is_zero(&arg6), 110);
            0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::floor_u64(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::mul_div(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::sub(v1, v2), 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::from_u64(arg5), arg6))
        };
        assert!(v3 >= arg4, 111);
        (v3, v2)
    }

    public(friend) fun destroy_symbol(arg0: Symbol) : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPriceConfig {
        let Symbol {
            open_enabled                 : _,
            decrease_enabled             : _,
            liquidate_enabled            : _,
            supported_collaterals        : _,
            funding_fee_model            : _,
            price_config                 : v5,
            last_update                  : _,
            opening_amount               : _,
            opening_size                 : _,
            realised_pnl                 : _,
            unrealised_funding_fee_value : _,
            acc_funding_rate             : _,
        } = arg0;
        v5
    }

    public(friend) fun force_settle_position<T0>(arg0: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::admin::AdminCap, arg1: &mut Vault<T0>, arg2: &mut Symbol, arg3: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::Position<T0>) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2, v3, v4, v5, v6) = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::force_settle<T0>(arg0, arg3, arg1.acc_reserving_rate, arg2.acc_funding_rate);
        arg2.opening_size = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::sub(arg2.opening_size, v6);
        arg2.opening_amount = arg2.opening_amount - v5;
        arg2.unrealised_funding_fee_value = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::sub(arg2.unrealised_funding_fee_value, v3);
        arg1.reserved_amount = arg1.reserved_amount - v1;
        arg1.unrealised_reserving_fee_amount = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::sub(arg1.unrealised_reserving_fee_amount, v2);
        0x2::balance::join<T0>(&mut arg1.liquidity, v0);
        v4
    }

    public(friend) fun liquidate_position<T0>(arg0: &mut Vault<T0>, arg1: &mut Symbol, arg2: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::Position<T0>, arg3: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel, arg4: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::FundingFeeModel, arg5: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg6: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg7: bool, arg8: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg9: u64, arg10: address) : (0x2::balance::Balance<T0>, LiquidatePositionEvent) {
        assert!(arg0.enabled, 100);
        assert!(arg1.liquidate_enabled, 106);
        assert!(0x2::object::id<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel>(arg3) == arg0.reserving_fee_model, 112);
        assert!(0x2::object::id<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::FundingFeeModel>(arg4) == arg1.funding_fee_model, 113);
        refresh_vault<T0>(arg0, arg3, arg9);
        let v0 = symbol_delta_size(arg1, arg6, arg7);
        refresh_symbol(arg1, arg4, v0, arg8, arg9);
        let (v1, v2, v3, v4, v5, v6, v7, v8, v9, v10) = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::liquidate_position<T0>(arg2, arg5, arg6, arg7, arg0.acc_reserving_rate, arg1.acc_funding_rate);
        arg0.reserved_amount = arg0.reserved_amount - v4;
        arg0.unrealised_reserving_fee_amount = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::sub(arg0.unrealised_reserving_fee_amount, v6);
        0x2::balance::join<T0>(&mut arg0.liquidity, v9);
        arg1.opening_size = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::sub(arg1.opening_size, v5);
        arg1.opening_amount = arg1.opening_amount - v3;
        arg1.unrealised_funding_fee_value = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::sub(arg1.unrealised_funding_fee_value, v8);
        let v11 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::sub_with_decimal(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::from_decimal(true, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::coins_to_value(arg5, v2)), v7);
        arg1.realised_pnl = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::add(arg1.realised_pnl, v11);
        let v12 = LiquidatePositionEvent{
            liquidator              : arg10,
            collateral_price        : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg5),
            index_price             : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg6),
            position_size           : v5,
            reserving_fee_value     : v7,
            funding_fee_value       : v8,
            delta_realised_pnl      : v11,
            loss_amount             : v2,
            liquidator_bonus_amount : v1,
            liquidation_amount      : v3,
        };
        (v10, v12)
    }

    public(friend) fun mut_symbol_price_config(arg0: &mut Symbol) : &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPriceConfig {
        &mut arg0.price_config
    }

    public(friend) fun mut_vault_price_config<T0>(arg0: &mut Vault<T0>) : &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPriceConfig {
        &mut arg0.price_config
    }

    public(friend) fun new_symbol(arg0: 0x2::object::ID, arg1: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPriceConfig) : Symbol {
        Symbol{
            open_enabled                 : true,
            decrease_enabled             : true,
            liquidate_enabled            : true,
            supported_collaterals        : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            funding_fee_model            : arg0,
            price_config                 : arg1,
            last_update                  : 0,
            opening_amount               : 0,
            opening_size                 : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::zero(),
            realised_pnl                 : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::zero(),
            unrealised_funding_fee_value : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::zero(),
            acc_funding_rate             : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::srate::zero(),
        }
    }

    public(friend) fun new_vault<T0>(arg0: u256, arg1: 0x2::object::ID, arg2: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPriceConfig) : Vault<T0> {
        Vault<T0>{
            enabled                         : true,
            weight                          : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::from_raw(arg0),
            reserving_fee_model             : arg1,
            price_config                    : arg2,
            last_update                     : 0,
            liquidity                       : 0x2::balance::zero<T0>(),
            reserved_amount                 : 0,
            unrealised_reserving_fee_amount : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::zero(),
            acc_reserving_rate              : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::zero(),
        }
    }

    public(friend) fun open_position<T0>(arg0: &mut Vault<T0>, arg1: &mut Symbol, arg2: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::fee::FeeConfig, arg3: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel, arg4: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::FundingFeeModel, arg5: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::PositionConfig, arg6: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg7: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg8: &mut 0x2::balance::Balance<T0>, arg9: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg10: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate, arg11: 0x1::option::Option<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate>, arg12: bool, arg13: u64, arg14: u64, arg15: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg16: u64, arg17: address) : OpenPositionResult<T0> {
        assert!(arg0.enabled, 100);
        assert!(arg1.open_enabled, 104);
        assert!(0x2::object::id<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel>(arg3) == arg0.reserving_fee_model, 112);
        assert!(0x2::object::id<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::FundingFeeModel>(arg4) == arg1.funding_fee_model, 113);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.supported_collaterals, &v0), 103);
        assert!(0x2::balance::value<T0>(&arg0.liquidity) > arg14, 102);
        refresh_vault<T0>(arg0, arg3, arg16);
        let v1 = symbol_delta_size(arg1, arg7, arg12);
        refresh_symbol(arg1, arg4, v1, arg15, arg16);
        let (v2, v3, v4) = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::unwrap_open_position_result<T0>(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::open_position<T0>(arg5, arg6, arg7, &mut arg0.liquidity, arg8, arg9, arg13, arg14, arg0.acc_reserving_rate, arg1.acc_funding_rate, arg16));
        let v5 = v3;
        let v6 = v2;
        let v7 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::floor_u64(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::mul_with_rate(v4, arg10));
        let v8 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::floor_u64(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::mul_with_rate(v4, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::fee::get_fee_rate(arg2)));
        let v9 = if (0x1::option::is_some<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate>(&arg11)) {
            0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::floor_u64(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::mul_with_rate(v4, *0x1::option::borrow<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate>(&arg11)))
        } else {
            0
        };
        arg0.reserved_amount = arg0.reserved_amount + arg14;
        assert!(0x2::balance::join<T0>(&mut arg0.liquidity, v5) > v7 + v8 + v9, 102);
        let v10 = if (v9 > 0) {
            0x1::option::some<0x2::balance::Balance<T0>>(0x2::balance::split<T0>(&mut arg0.liquidity, v9))
        } else {
            0x1::option::none<0x2::balance::Balance<T0>>()
        };
        arg1.opening_size = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::add(arg1.opening_size, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::position_size<T0>(&v6));
        arg1.opening_amount = arg1.opening_amount + arg13;
        let v11 = if (v9 > 0) {
            0x1::option::some<u64>(v9)
        } else {
            0x1::option::none<u64>()
        };
        let v12 = OpenPositionSuccessEvent{
            position_config        : *arg5,
            collateral_price       : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg6),
            index_price            : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg7),
            open_amount            : arg13,
            open_fee_amount        : 0x2::balance::value<T0>(&v5),
            reserve_amount         : arg14,
            collateral_amount      : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::collateral_amount<T0>(&v6),
            referral_rebate_amount : v7,
            fee_rebate_amount      : v8,
            scard_rebate_amount    : v11,
            referrer               : arg17,
        };
        OpenPositionResult<T0>{
            position        : v6,
            referral_rebate : 0x2::balance::split<T0>(&mut arg0.liquidity, v7),
            fee_rebate      : 0x2::balance::split<T0>(&mut arg0.liquidity, v8),
            scard_rebate    : v10,
            event           : v12,
        }
    }

    public(friend) fun pledge_in_position<T0>(arg0: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::Position<T0>, arg1: 0x2::balance::Balance<T0>) : PledgeInPositionEvent {
        0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::pledge_in_position<T0>(arg0, arg1);
        PledgeInPositionEvent{pledge_amount: 0x2::balance::value<T0>(&arg1)}
    }

    public(friend) fun redeem_from_position<T0>(arg0: &mut Vault<T0>, arg1: &mut Symbol, arg2: &mut 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::Position<T0>, arg3: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel, arg4: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::FundingFeeModel, arg5: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg6: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg7: bool, arg8: u64, arg9: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg10: u64) : (0x2::balance::Balance<T0>, RedeemFromPositionEvent) {
        assert!(0x2::object::id<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel>(arg3) == arg0.reserving_fee_model, 112);
        assert!(0x2::object::id<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::FundingFeeModel>(arg4) == arg1.funding_fee_model, 113);
        refresh_vault<T0>(arg0, arg3, arg10);
        let v0 = symbol_delta_size(arg1, arg6, arg7);
        refresh_symbol(arg1, arg4, v0, arg9, arg10);
        let v1 = RedeemFromPositionEvent{
            collateral_price : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg5),
            index_price      : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::price_of(arg6),
            redeem_amount    : arg8,
        };
        (0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::redeem_from_position<T0>(arg2, arg5, arg6, arg7, arg8, arg0.acc_reserving_rate, arg1.acc_funding_rate, arg10), v1)
    }

    fun refresh_symbol(arg0: &mut Symbol, arg1: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::FundingFeeModel, arg2: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::SDecimal, arg3: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg4: u64) {
        let v0 = symbol_delta_funding_rate(arg0, arg1, arg2, arg3, arg4);
        arg0.acc_funding_rate = symbol_acc_funding_rate(arg0, v0);
        arg0.unrealised_funding_fee_value = symbol_unrealised_funding_fee_value(arg0, v0);
        arg0.last_update = arg4;
    }

    fun refresh_vault<T0>(arg0: &mut Vault<T0>, arg1: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel, arg2: u64) {
        let v0 = vault_delta_reserving_rate<T0>(arg0, arg1, arg2);
        arg0.acc_reserving_rate = vault_acc_reserving_rate<T0>(arg0, v0);
        arg0.unrealised_reserving_fee_amount = vault_unrealised_reserving_fee_amount<T0>(arg0, v0);
        arg0.last_update = arg2;
    }

    public(friend) fun remove_collateral_from_symbol<T0>(arg0: &mut Symbol) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.supported_collaterals, &v0);
    }

    public(friend) fun set_symbol_status(arg0: &mut Symbol, arg1: bool, arg2: bool, arg3: bool) {
        arg0.open_enabled = arg1;
        arg0.decrease_enabled = arg2;
        arg0.liquidate_enabled = arg3;
    }

    public(friend) fun set_vault_status<T0>(arg0: &mut Vault<T0>, arg1: bool) {
        arg0.enabled = arg1;
    }

    public(friend) fun set_vault_weight<T0>(arg0: &mut Vault<T0>, arg1: u256) {
        arg0.weight = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::from_raw(arg1);
    }

    public(friend) fun swap_in<T0>(arg0: &mut Vault<T0>, arg1: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::RebaseFeeModel, arg2: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg3: 0x2::balance::Balance<T0>, arg4: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg5: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg6: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal) : (0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal) {
        assert!(arg0.enabled, 100);
        let v0 = 0x2::balance::value<T0>(&arg3);
        assert!(v0 > 0, 107);
        0x2::balance::join<T0>(&mut arg0.liquidity, arg3);
        let v1 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::coins_to_value(arg2, v0);
        let v2 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::mul_with_rate(v1, compute_rebase_fee_rate(arg1, true, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::add(arg4, v1), 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::add(arg5, v1), arg0.weight, arg6));
        (0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::sub(v1, v2), v2)
    }

    public(friend) fun swap_out<T0>(arg0: &mut Vault<T0>, arg1: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::RebaseFeeModel, arg2: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg3: u64, arg4: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg5: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg6: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg7: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal) : (0x2::balance::Balance<T0>, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal) {
        assert!(arg0.enabled, 100);
        assert!(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::lt(&arg4, &arg5), 101);
        let v0 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::mul_with_rate(arg4, compute_rebase_fee_rate(arg1, false, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::sub(arg5, arg4), arg6, arg0.weight, arg7));
        let v1 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::floor_u64(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::value_to_coins(arg2, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::sub(arg4, v0)));
        assert!(v1 >= arg3, 111);
        assert!(v1 < 0x2::balance::value<T0>(&arg0.liquidity), 102);
        (0x2::balance::split<T0>(&mut arg0.liquidity, v1), v0)
    }

    public fun symbol_acc_funding_rate(arg0: &Symbol, arg1: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::srate::SRate) : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::srate::SRate {
        0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::srate::add(arg0.acc_funding_rate, arg1)
    }

    public fun symbol_decrease_enabled(arg0: &Symbol) : bool {
        arg0.decrease_enabled
    }

    public fun symbol_delta_funding_rate(arg0: &Symbol, arg1: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::FundingFeeModel, arg2: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::SDecimal, arg3: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg4: u64) : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::srate::SRate {
        if (arg0.last_update > 0) {
            let v0 = arg4 - arg0.last_update;
            if (v0 > 0) {
                return 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::compute_funding_fee_rate(arg1, symbol_pnl_per_lp(arg0, arg2, arg3), v0)
            };
        };
        0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::srate::zero()
    }

    public fun symbol_delta_size(arg0: &Symbol, arg1: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg2: bool) : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::SDecimal {
        let v0 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::coins_to_value(arg1, arg0.opening_amount);
        let (v1, v2) = if (0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::gt(&v0, &arg0.opening_size)) {
            (!arg2, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::sub(v0, arg0.opening_size))
        } else {
            (arg2, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::sub(arg0.opening_size, v0))
        };
        0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::from_decimal(v1, v2)
    }

    public fun symbol_funding_fee_model(arg0: &Symbol) : &0x2::object::ID {
        &arg0.funding_fee_model
    }

    public fun symbol_liquidate_enabled(arg0: &Symbol) : bool {
        arg0.liquidate_enabled
    }

    public fun symbol_open_enabled(arg0: &Symbol) : bool {
        arg0.open_enabled
    }

    public fun symbol_opening_amount(arg0: &Symbol) : u64 {
        arg0.opening_amount
    }

    public fun symbol_opening_size(arg0: &Symbol) : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal {
        arg0.opening_size
    }

    public fun symbol_pnl_per_lp(arg0: &Symbol, arg1: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::SDecimal, arg2: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal) : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::SDecimal {
        0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::div_by_decimal(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::add(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::add(arg0.realised_pnl, arg0.unrealised_funding_fee_value), arg1), arg2)
    }

    public fun symbol_price_config(arg0: &Symbol) : &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPriceConfig {
        &arg0.price_config
    }

    public fun symbol_supported_collaterals(arg0: &Symbol) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.supported_collaterals
    }

    public fun symbol_unrealised_funding_fee_value(arg0: &Symbol, arg1: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::srate::SRate) : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::SDecimal {
        0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::add(arg0.unrealised_funding_fee_value, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::from_decimal(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::srate::is_positive(&arg1), 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::mul_with_rate(arg0.opening_size, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::srate::value(&arg1))))
    }

    public(friend) fun unwrap_decrease_position_result<T0>(arg0: DecreasePositionResult<T0>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, 0x1::option::Option<0x2::balance::Balance<T0>>, DecreasePositionSuccessEvent) {
        let DecreasePositionResult {
            to_trader       : v0,
            referral_rebate : v1,
            fee_rebate      : v2,
            scard_rebate    : v3,
            event           : v4,
        } = arg0;
        (v0, v1, v2, v3, v4)
    }

    public(friend) fun unwrap_open_position_result<T0>(arg0: OpenPositionResult<T0>) : (0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::position::Position<T0>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, 0x1::option::Option<0x2::balance::Balance<T0>>, OpenPositionSuccessEvent) {
        let OpenPositionResult {
            position        : v0,
            referral_rebate : v1,
            fee_rebate      : v2,
            scard_rebate    : v3,
            event           : v4,
        } = arg0;
        (v0, v1, v2, v3, v4)
    }

    public(friend) fun valuate_symbol(arg0: &mut Symbol, arg1: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::FundingFeeModel, arg2: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg3: bool, arg4: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg5: u64) : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::SDecimal {
        assert!(0x2::object::id<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::FundingFeeModel>(arg1) == arg0.funding_fee_model, 113);
        let v0 = symbol_delta_size(arg0, arg2, arg3);
        refresh_symbol(arg0, arg1, v0, arg4, arg5);
        0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::sdecimal::add(v0, arg0.unrealised_funding_fee_value)
    }

    public(friend) fun valuate_vault<T0>(arg0: &mut Vault<T0>, arg1: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel, arg2: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg3: u64) : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal {
        assert!(arg0.enabled, 100);
        assert!(0x2::object::id<0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel>(arg1) == arg0.reserving_fee_model, 112);
        refresh_vault<T0>(arg0, arg1, arg3);
        0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::coins_to_value(arg2, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::floor_u64(vault_supply_amount<T0>(arg0)))
    }

    public fun vault_acc_reserving_rate<T0>(arg0: &Vault<T0>, arg1: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate) : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate {
        0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::add(arg0.acc_reserving_rate, arg1)
    }

    public fun vault_delta_reserving_rate<T0>(arg0: &Vault<T0>, arg1: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::ReservingFeeModel, arg2: u64) : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate {
        if (arg0.last_update > 0) {
            let v0 = arg2 - arg0.last_update;
            if (v0 > 0) {
                return 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::compute_reserving_fee_rate(arg1, vault_utilization<T0>(arg0), v0)
            };
        };
        0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::zero()
    }

    public fun vault_enabled<T0>(arg0: &Vault<T0>) : bool {
        arg0.enabled
    }

    public fun vault_liquidity_amount<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.liquidity)
    }

    public fun vault_price_config<T0>(arg0: &Vault<T0>) : &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPriceConfig {
        &arg0.price_config
    }

    public fun vault_reserved_amount<T0>(arg0: &Vault<T0>) : u64 {
        arg0.reserved_amount
    }

    public fun vault_reserving_fee_model<T0>(arg0: &Vault<T0>) : &0x2::object::ID {
        &arg0.reserving_fee_model
    }

    public fun vault_supply_amount<T0>(arg0: &Vault<T0>) : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal {
        0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::add(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::from_u64(0x2::balance::value<T0>(&arg0.liquidity) + arg0.reserved_amount), arg0.unrealised_reserving_fee_amount)
    }

    public fun vault_unrealised_reserving_fee_amount<T0>(arg0: &Vault<T0>, arg1: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate) : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal {
        0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::add(arg0.unrealised_reserving_fee_amount, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::mul_with_rate(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::from_u64(arg0.reserved_amount), arg1))
    }

    public fun vault_utilization<T0>(arg0: &Vault<T0>) : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::Rate {
        let v0 = vault_supply_amount<T0>(arg0);
        if (0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::is_zero(&v0)) {
            0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::zero()
        } else {
            0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::to_rate(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::div(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::from_u64(arg0.reserved_amount), v0))
        }
    }

    public fun vault_weight<T0>(arg0: &Vault<T0>) : 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal {
        arg0.weight
    }

    public(friend) fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::model::RebaseFeeModel, arg2: &0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::AggPrice, arg3: u64, arg4: u64, arg5: u64, arg6: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg7: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg8: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal, arg9: 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal) : (0x2::balance::Balance<T0>, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::Decimal) {
        assert!(arg0.enabled, 100);
        assert!(arg3 > 0, 109);
        let v0 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::mul_div(arg6, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::from_u64(arg3), 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::from_u64(arg5));
        assert!(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::le(&v0, &arg7), 101);
        let v1 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::mul_with_rate(v0, compute_rebase_fee_rate(arg1, false, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::sub(arg7, v0), 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::sub(arg8, v0), arg0.weight, arg9));
        let v2 = 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::floor_u64(0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::agg_price::value_to_coins(arg2, 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::decimal::sub(v0, v1)));
        assert!(v2 <= 0x2::balance::value<T0>(&arg0.liquidity), 102);
        let v3 = 0x2::balance::split<T0>(&mut arg0.liquidity, v2);
        assert!(0x2::balance::value<T0>(&v3) >= arg4, 111);
        (v3, v1)
    }

    // decompiled from Move bytecode v6
}

