module 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::pool {
    struct Vault<phantom T0> has store {
        enabled: bool,
        weight: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        reserving_fee_model: 0x2::object::ID,
        price_config: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPriceConfig,
        last_update: u64,
        liquidity: 0x2::balance::Balance<T0>,
        reserved_amount: u64,
        unrealised_reserving_fee_amount: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        acc_reserving_rate: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::rate::Rate,
    }

    struct Symbol has store {
        open_enabled: bool,
        decrease_enabled: bool,
        liquidate_enabled: bool,
        supported_collaterals: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        funding_fee_model: 0x2::object::ID,
        price_config: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPriceConfig,
        last_update: u64,
        opening_amount: u64,
        opening_size: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        realised_pnl: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::SDecimal,
        unrealised_funding_fee_value: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::SDecimal,
        acc_funding_rate: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::srate::SRate,
    }

    struct OpenPositionResult<phantom T0> {
        position: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::Position<T0>,
        rebate: 0x2::balance::Balance<T0>,
        event: OpenPositionSuccessEvent,
    }

    struct DecreasePositionResult<phantom T0> {
        to_trader: 0x2::balance::Balance<T0>,
        rebate: 0x2::balance::Balance<T0>,
        event: DecreasePositionSuccessEvent,
    }

    struct OpenPositionSuccessEvent has copy, drop {
        position_config: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::PositionConfig,
        collateral_price: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        index_price: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        open_amount: u64,
        open_fee_amount: u64,
        reserve_amount: u64,
        collateral_amount: u64,
        rebate_amount: u64,
    }

    struct OpenPositionFailedEvent has copy, drop {
        position_config: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::PositionConfig,
        collateral_price: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        index_price: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        open_amount: u64,
        collateral_amount: u64,
        code: u64,
    }

    struct DecreasePositionSuccessEvent has copy, drop {
        collateral_price: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        index_price: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        decrease_amount: u64,
        decrease_fee_value: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        reserving_fee_value: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        funding_fee_value: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::SDecimal,
        delta_realised_pnl: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::SDecimal,
        closed: bool,
        has_profit: bool,
        settled_amount: u64,
        rebate_amount: u64,
    }

    struct DecreasePositionFailedEvent has copy, drop {
        collateral_price: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        index_price: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        decrease_amount: u64,
        code: u64,
    }

    struct DecreaseReservedFromPositionEvent has copy, drop {
        decrease_amount: u64,
    }

    struct PledgeInPositionEvent has copy, drop {
        pledge_amount: u64,
    }

    struct RedeemFromPositionEvent has copy, drop {
        collateral_price: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        index_price: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        redeem_amount: u64,
    }

    struct LiquidatePositionEvent has copy, drop {
        liquidator: address,
        collateral_price: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        index_price: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        reserving_fee_value: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal,
        funding_fee_value: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::SDecimal,
        delta_realised_pnl: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::SDecimal,
        loss_amount: u64,
        liquidator_bonus_amount: u64,
    }

    public fun compute_rebase_fee_rate(arg0: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::RebaseFeeModel, arg1: bool, arg2: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg3: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg4: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg5: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal) : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::rate::Rate {
        if (0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::eq(&arg2, &arg3)) {
            0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::rate::zero()
        } else {
            0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::compute_rebase_fee_rate(arg0, arg1, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::to_rate(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::div(arg2, arg3)), 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::to_rate(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::div(arg4, arg5)))
        }
    }

    public(friend) fun add_collateral_to_symbol<T0>(arg0: &mut Symbol) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.supported_collaterals, 0x1::type_name::get<T0>());
    }

    public(friend) fun decrease_position<T0>(arg0: &mut Vault<T0>, arg1: &mut Symbol, arg2: &mut 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::Position<T0>, arg3: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::ReservingFeeModel, arg4: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::FundingFeeModel, arg5: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPrice, arg6: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPrice, arg7: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg8: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::rate::Rate, arg9: bool, arg10: u64, arg11: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg12: u64) : (u64, 0x1::option::Option<DecreasePositionResult<T0>>, 0x1::option::Option<DecreasePositionFailedEvent>) {
        assert!(arg0.enabled, 1);
        assert!(arg1.decrease_enabled, 6);
        assert!(0x2::object::id<0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::ReservingFeeModel>(arg3) == arg0.reserving_fee_model, 13);
        assert!(0x2::object::id<0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::FundingFeeModel>(arg4) == arg1.funding_fee_model, 14);
        let v0 = vault_supply_amount<T0>(arg0);
        refresh_vault<T0>(arg0, arg3, v0, arg12);
        let v1 = symbol_delta_size(arg1, arg6, arg9);
        refresh_symbol(arg1, arg4, v1, arg11, arg12);
        let (v2, v3) = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::decrease_position<T0>(arg2, arg5, arg6, arg7, arg9, arg10, arg0.acc_reserving_rate, arg1.acc_funding_rate, arg12);
        if (v2 > 0) {
            0x1::option::destroy_none<0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::DecreasePositionResult<T0>>(v3);
            let v4 = DecreasePositionFailedEvent{
                collateral_price : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::price_of(arg5),
                index_price      : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::price_of(arg6),
                decrease_amount  : arg10,
                code             : v2,
            };
            return (v2, 0x1::option::none<DecreasePositionResult<T0>>(), 0x1::option::some<DecreasePositionFailedEvent>(v4))
        };
        let (v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15) = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::unwrap_decrease_position_result<T0>(0x1::option::destroy_some<0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::DecreasePositionResult<T0>>(v3));
        let v16 = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::mul_with_rate(v11, arg8);
        let v17 = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::floor_u64(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::value_to_coins(arg5, v16));
        arg0.reserved_amount = arg0.reserved_amount - v8;
        arg0.unrealised_reserving_fee_amount = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::sub(arg0.unrealised_reserving_fee_amount, v10);
        assert!(0x2::balance::join<T0>(&mut arg0.liquidity, v14) > v17, 3);
        arg1.opening_size = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::sub(arg1.opening_size, v9);
        arg1.opening_amount = arg1.opening_amount - arg10;
        arg1.unrealised_funding_fee_value = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::sub(arg1.unrealised_funding_fee_value, v13);
        let v18 = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::sub_with_decimal(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::from_decimal(!v6, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::coins_to_value(arg5, v7)), 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::add(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::sub(v11, v16), v12));
        arg1.realised_pnl = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::add(arg1.realised_pnl, v18);
        let v19 = DecreasePositionSuccessEvent{
            collateral_price    : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::price_of(arg5),
            index_price         : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::price_of(arg6),
            decrease_amount     : arg10,
            decrease_fee_value  : v11,
            reserving_fee_value : v12,
            funding_fee_value   : v13,
            delta_realised_pnl  : v18,
            closed              : v5,
            has_profit          : v6,
            settled_amount      : v7,
            rebate_amount       : v17,
        };
        let v20 = DecreasePositionResult<T0>{
            to_trader : v15,
            rebate    : 0x2::balance::split<T0>(&mut arg0.liquidity, v17),
            event     : v19,
        };
        (v2, 0x1::option::some<DecreasePositionResult<T0>>(v20), 0x1::option::none<DecreasePositionFailedEvent>())
    }

    public(friend) fun decrease_reserved_from_position<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::Position<T0>, arg2: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::ReservingFeeModel, arg3: u64, arg4: u64) : DecreaseReservedFromPositionEvent {
        assert!(0x2::object::id<0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::ReservingFeeModel>(arg2) == arg0.reserving_fee_model, 13);
        let v0 = vault_supply_amount<T0>(arg0);
        refresh_vault<T0>(arg0, arg2, v0, arg4);
        let v1 = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::decrease_reserved_from_position<T0>(arg1, arg3, arg0.acc_reserving_rate);
        arg0.reserved_amount = arg0.reserved_amount - 0x2::balance::value<T0>(&v1);
        0x2::balance::join<T0>(&mut arg0.liquidity, v1);
        DecreaseReservedFromPositionEvent{decrease_amount: arg3}
    }

    public(friend) fun deposit<T0>(arg0: &mut Vault<T0>, arg1: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::RebaseFeeModel, arg2: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPrice, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg7: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg8: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg9: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal) : u64 {
        assert!(arg0.enabled, 1);
        let v0 = 0x2::balance::value<T0>(&arg3);
        assert!(v0 > 0, 9);
        let v1 = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::coins_to_value(arg2, v0);
        0x2::balance::join<T0>(&mut arg0.liquidity, arg3);
        let v2 = if (arg5 == 0) {
            assert!(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::is_zero(&arg6), 11);
            truncate_decimal(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::sub(v1, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::mul_with_rate(v1, compute_rebase_fee_rate(arg1, true, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::add(arg7, v1), 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::add(arg8, v1), arg0.weight, arg9))))
        } else {
            assert!(!0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::is_zero(&arg6), 11);
            0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::floor_u64(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::mul_with_rate(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::from_u64(arg5), 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::to_rate(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::div(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::sub(v1, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::mul_with_rate(v1, compute_rebase_fee_rate(arg1, true, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::add(arg7, v1), 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::add(arg8, v1), arg0.weight, arg9))), arg6))))
        };
        assert!(v2 >= arg4, 12);
        v2
    }

    public(friend) fun liquidate_position<T0>(arg0: &mut Vault<T0>, arg1: &mut Symbol, arg2: &mut 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::Position<T0>, arg3: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::ReservingFeeModel, arg4: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::FundingFeeModel, arg5: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPrice, arg6: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPrice, arg7: bool, arg8: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg9: u64, arg10: address) : (0x2::balance::Balance<T0>, LiquidatePositionEvent) {
        assert!(arg0.enabled, 1);
        assert!(arg1.liquidate_enabled, 7);
        assert!(0x2::object::id<0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::ReservingFeeModel>(arg3) == arg0.reserving_fee_model, 13);
        assert!(0x2::object::id<0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::FundingFeeModel>(arg4) == arg1.funding_fee_model, 14);
        let v0 = vault_supply_amount<T0>(arg0);
        refresh_vault<T0>(arg0, arg3, v0, arg9);
        let v1 = symbol_delta_size(arg1, arg6, arg7);
        refresh_symbol(arg1, arg4, v1, arg8, arg9);
        let (v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::liquidate_position<T0>(arg2, arg5, arg6, arg7, arg0.acc_reserving_rate, arg1.acc_funding_rate);
        arg0.reserved_amount = arg0.reserved_amount - v5;
        arg0.unrealised_reserving_fee_amount = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::sub(arg0.unrealised_reserving_fee_amount, v7);
        0x2::balance::join<T0>(&mut arg0.liquidity, v10);
        arg1.opening_size = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::sub(arg1.opening_size, v6);
        arg1.opening_amount = arg1.opening_amount - v4;
        arg1.unrealised_funding_fee_value = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::sub(arg1.unrealised_funding_fee_value, v9);
        let v12 = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::sub_with_decimal(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::from_decimal(true, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::coins_to_value(arg5, v3)), v8);
        arg1.realised_pnl = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::add(arg1.realised_pnl, v12);
        let v13 = LiquidatePositionEvent{
            liquidator              : arg10,
            collateral_price        : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::price_of(arg5),
            index_price             : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::price_of(arg6),
            reserving_fee_value     : v8,
            funding_fee_value       : v9,
            delta_realised_pnl      : v12,
            loss_amount             : v3,
            liquidator_bonus_amount : v2,
        };
        (v11, v13)
    }

    public(friend) fun new_symbol(arg0: 0x2::object::ID, arg1: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPriceConfig) : Symbol {
        Symbol{
            open_enabled                 : true,
            decrease_enabled             : true,
            liquidate_enabled            : true,
            supported_collaterals        : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            funding_fee_model            : arg0,
            price_config                 : arg1,
            last_update                  : 0,
            opening_amount               : 0,
            opening_size                 : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::zero(),
            realised_pnl                 : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::zero(),
            unrealised_funding_fee_value : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::zero(),
            acc_funding_rate             : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::srate::zero(),
        }
    }

    public(friend) fun new_vault<T0>(arg0: u256, arg1: 0x2::object::ID, arg2: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPriceConfig) : Vault<T0> {
        Vault<T0>{
            enabled                         : true,
            weight                          : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::from_raw(arg0),
            reserving_fee_model             : arg1,
            price_config                    : arg2,
            last_update                     : 0,
            liquidity                       : 0x2::balance::zero<T0>(),
            reserved_amount                 : 0,
            unrealised_reserving_fee_amount : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::zero(),
            acc_reserving_rate              : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::rate::zero(),
        }
    }

    public(friend) fun open_position<T0>(arg0: &mut Vault<T0>, arg1: &mut Symbol, arg2: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::ReservingFeeModel, arg3: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::FundingFeeModel, arg4: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::PositionConfig, arg5: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPrice, arg6: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPrice, arg7: &mut 0x2::balance::Balance<T0>, arg8: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg9: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::rate::Rate, arg10: bool, arg11: u64, arg12: u64, arg13: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg14: u64) : (u64, 0x1::option::Option<OpenPositionResult<T0>>, 0x1::option::Option<OpenPositionFailedEvent>) {
        assert!(arg0.enabled, 1);
        assert!(arg1.open_enabled, 5);
        assert!(0x2::object::id<0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::ReservingFeeModel>(arg2) == arg0.reserving_fee_model, 13);
        assert!(0x2::object::id<0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::FundingFeeModel>(arg3) == arg1.funding_fee_model, 14);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.supported_collaterals, &v0), 4);
        assert!(0x2::balance::value<T0>(&arg0.liquidity) > arg12, 3);
        let v1 = vault_supply_amount<T0>(arg0);
        refresh_vault<T0>(arg0, arg2, v1, arg14);
        let v2 = symbol_delta_size(arg1, arg6, arg10);
        refresh_symbol(arg1, arg3, v2, arg13, arg14);
        let (v3, v4) = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::open_position<T0>(arg4, arg5, arg6, &mut arg0.liquidity, arg7, arg8, arg11, arg12, arg0.acc_reserving_rate, arg1.acc_funding_rate, arg14);
        if (v3 > 0) {
            0x1::option::destroy_none<0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::OpenPositionResult<T0>>(v4);
            let v5 = OpenPositionFailedEvent{
                position_config   : *arg4,
                collateral_price  : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::price_of(arg5),
                index_price       : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::price_of(arg6),
                open_amount       : arg11,
                collateral_amount : 0x2::balance::value<T0>(arg7),
                code              : v3,
            };
            return (v3, 0x1::option::none<OpenPositionResult<T0>>(), 0x1::option::some<OpenPositionFailedEvent>(v5))
        };
        let (v6, v7, v8) = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::unwrap_open_position_result<T0>(0x1::option::destroy_some<0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::OpenPositionResult<T0>>(v4));
        let v9 = v7;
        let v10 = v6;
        let v11 = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::floor_u64(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::mul_with_rate(v8, arg9));
        arg0.reserved_amount = arg0.reserved_amount + arg12;
        assert!(0x2::balance::join<T0>(&mut arg0.liquidity, v9) > v11, 3);
        arg1.opening_size = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::add(arg1.opening_size, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::position_size<T0>(&v10));
        arg1.opening_amount = arg1.opening_amount + arg11;
        let v12 = OpenPositionSuccessEvent{
            position_config   : *arg4,
            collateral_price  : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::price_of(arg5),
            index_price       : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::price_of(arg6),
            open_amount       : arg11,
            open_fee_amount   : 0x2::balance::value<T0>(&v9),
            reserve_amount    : arg12,
            collateral_amount : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::collateral_amount<T0>(&v10),
            rebate_amount     : v11,
        };
        let v13 = OpenPositionResult<T0>{
            position : v10,
            rebate   : 0x2::balance::split<T0>(&mut arg0.liquidity, v11),
            event    : v12,
        };
        (v3, 0x1::option::some<OpenPositionResult<T0>>(v13), 0x1::option::none<OpenPositionFailedEvent>())
    }

    public(friend) fun pledge_in_position<T0>(arg0: &mut 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::Position<T0>, arg1: 0x2::balance::Balance<T0>) : PledgeInPositionEvent {
        0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::pledge_in_position<T0>(arg0, arg1);
        PledgeInPositionEvent{pledge_amount: 0x2::balance::value<T0>(&arg1)}
    }

    public(friend) fun redeem_from_position<T0>(arg0: &mut Vault<T0>, arg1: &mut Symbol, arg2: &mut 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::Position<T0>, arg3: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::ReservingFeeModel, arg4: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::FundingFeeModel, arg5: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPrice, arg6: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPrice, arg7: bool, arg8: u64, arg9: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg10: u64) : (0x2::balance::Balance<T0>, RedeemFromPositionEvent) {
        assert!(0x2::object::id<0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::ReservingFeeModel>(arg3) == arg0.reserving_fee_model, 13);
        assert!(0x2::object::id<0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::FundingFeeModel>(arg4) == arg1.funding_fee_model, 14);
        let v0 = vault_supply_amount<T0>(arg0);
        refresh_vault<T0>(arg0, arg3, v0, arg10);
        let v1 = symbol_delta_size(arg1, arg6, arg7);
        refresh_symbol(arg1, arg4, v1, arg9, arg10);
        let v2 = RedeemFromPositionEvent{
            collateral_price : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::price_of(arg5),
            index_price      : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::price_of(arg6),
            redeem_amount    : arg8,
        };
        (0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::redeem_from_position<T0>(arg2, arg5, arg6, arg7, arg8, arg0.acc_reserving_rate, arg1.acc_funding_rate, arg10), v2)
    }

    fun refresh_symbol(arg0: &mut Symbol, arg1: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::FundingFeeModel, arg2: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::SDecimal, arg3: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg4: u64) {
        let v0 = symbol_delta_funding_rate(arg0, arg1, arg2, arg3, arg4);
        arg0.acc_funding_rate = symbol_acc_funding_rate(arg0, v0);
        arg0.unrealised_funding_fee_value = symbol_unrealised_funding_fee_value(arg0, v0);
        arg0.last_update = arg4;
    }

    fun refresh_vault<T0>(arg0: &mut Vault<T0>, arg1: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::ReservingFeeModel, arg2: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg3: u64) {
        let v0 = vault_delta_reserving_rate<T0>(arg0, arg1, arg2, arg3);
        arg0.acc_reserving_rate = vault_acc_reserving_rate<T0>(arg0, v0);
        arg0.unrealised_reserving_fee_amount = vault_unrealised_reserving_fee_amount<T0>(arg0, v0);
        arg0.last_update = arg3;
    }

    public(friend) fun remove_collateral_from_symbol<T0>(arg0: &mut Symbol) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.supported_collaterals, &v0);
    }

    public(friend) fun swap_in<T0>(arg0: &mut Vault<T0>, arg1: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::RebaseFeeModel, arg2: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPrice, arg3: 0x2::balance::Balance<T0>, arg4: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg5: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg6: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal) : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal {
        assert!(arg0.enabled, 1);
        let v0 = 0x2::balance::value<T0>(&arg3);
        assert!(v0 > 0, 8);
        0x2::balance::join<T0>(&mut arg0.liquidity, arg3);
        let v1 = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::coins_to_value(arg2, v0);
        0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::sub(v1, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::mul_with_rate(v1, compute_rebase_fee_rate(arg1, true, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::add(arg4, v1), 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::add(arg5, v1), arg0.weight, arg6)))
    }

    public(friend) fun swap_out<T0>(arg0: &mut Vault<T0>, arg1: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::RebaseFeeModel, arg2: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPrice, arg3: u64, arg4: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg5: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg6: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg7: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal) : 0x2::balance::Balance<T0> {
        assert!(arg0.enabled, 1);
        assert!(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::lt(&arg4, &arg5), 2);
        let v0 = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::floor_u64(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::value_to_coins(arg2, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::sub(arg4, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::mul_with_rate(arg4, compute_rebase_fee_rate(arg1, false, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::sub(arg5, arg4), arg6, arg0.weight, arg7)))));
        assert!(v0 >= arg3, 12);
        assert!(v0 < 0x2::balance::value<T0>(&arg0.liquidity), 3);
        0x2::balance::split<T0>(&mut arg0.liquidity, v0)
    }

    public fun symbol_acc_funding_rate(arg0: &Symbol, arg1: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::srate::SRate) : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::srate::SRate {
        0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::srate::add(arg0.acc_funding_rate, arg1)
    }

    public fun symbol_decrease_enabled(arg0: &Symbol) : bool {
        arg0.decrease_enabled
    }

    public fun symbol_delta_funding_rate(arg0: &Symbol, arg1: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::FundingFeeModel, arg2: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::SDecimal, arg3: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg4: u64) : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::srate::SRate {
        if (arg0.last_update > 0) {
            let v0 = arg4 - arg0.last_update;
            if (v0 > 0) {
                return 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::compute_funding_fee_rate(arg1, symbol_pnl_per_lp(arg0, arg2, arg3), v0)
            };
        };
        0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::srate::zero()
    }

    public fun symbol_delta_size(arg0: &Symbol, arg1: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPrice, arg2: bool) : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::SDecimal {
        let v0 = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::coins_to_value(arg1, arg0.opening_amount);
        let (v1, v2) = if (0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::gt(&v0, &arg0.opening_size)) {
            (!arg2, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::sub(v0, arg0.opening_size))
        } else {
            (arg2, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::sub(arg0.opening_size, v0))
        };
        0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::from_decimal(v1, v2)
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

    public fun symbol_opening_size(arg0: &Symbol) : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal {
        arg0.opening_size
    }

    public fun symbol_pnl_per_lp(arg0: &Symbol, arg1: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::SDecimal, arg2: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal) : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::SDecimal {
        0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::div_by_decimal(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::add(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::add(arg0.realised_pnl, arg0.unrealised_funding_fee_value), arg1), arg2)
    }

    public fun symbol_price_config(arg0: &Symbol) : &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPriceConfig {
        &arg0.price_config
    }

    public fun symbol_supported_collaterals(arg0: &Symbol) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.supported_collaterals
    }

    public fun symbol_unrealised_funding_fee_value(arg0: &Symbol, arg1: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::srate::SRate) : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::SDecimal {
        0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::add(arg0.unrealised_funding_fee_value, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::from_decimal(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::srate::is_positive(&arg1), 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::mul_with_rate(arg0.opening_size, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::srate::value(&arg1))))
    }

    fun truncate_decimal(arg0: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal) : u64 {
        ((0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::to_raw(arg0) / 1000000000000) as u64)
    }

    public(friend) fun unwrap_decrease_position_result<T0>(arg0: DecreasePositionResult<T0>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, DecreasePositionSuccessEvent) {
        let DecreasePositionResult {
            to_trader : v0,
            rebate    : v1,
            event     : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public(friend) fun unwrap_open_position_result<T0>(arg0: OpenPositionResult<T0>) : (0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::position::Position<T0>, 0x2::balance::Balance<T0>, OpenPositionSuccessEvent) {
        let OpenPositionResult {
            position : v0,
            rebate   : v1,
            event    : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public(friend) fun valuate_symbol(arg0: &mut Symbol, arg1: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::FundingFeeModel, arg2: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPrice, arg3: bool, arg4: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg5: u64) : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::SDecimal {
        assert!(0x2::object::id<0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::FundingFeeModel>(arg1) == arg0.funding_fee_model, 14);
        let v0 = symbol_delta_size(arg0, arg2, arg3);
        refresh_symbol(arg0, arg1, v0, arg4, arg5);
        0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::sdecimal::add(v0, arg0.unrealised_funding_fee_value)
    }

    public(friend) fun valuate_vault<T0>(arg0: &mut Vault<T0>, arg1: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::ReservingFeeModel, arg2: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPrice, arg3: u64) : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal {
        assert!(arg0.enabled, 1);
        assert!(0x2::object::id<0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::ReservingFeeModel>(arg1) == arg0.reserving_fee_model, 13);
        let v0 = vault_supply_amount<T0>(arg0);
        refresh_vault<T0>(arg0, arg1, v0, arg3);
        0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::coins_to_value(arg2, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::floor_u64(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::add(v0, arg0.unrealised_reserving_fee_amount)))
    }

    public fun vault_acc_reserving_rate<T0>(arg0: &Vault<T0>, arg1: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::rate::Rate) : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::rate::Rate {
        0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::rate::add(arg0.acc_reserving_rate, arg1)
    }

    public fun vault_delta_reserving_rate<T0>(arg0: &Vault<T0>, arg1: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::ReservingFeeModel, arg2: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg3: u64) : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::rate::Rate {
        if (arg0.last_update > 0) {
            let v0 = arg3 - arg0.last_update;
            if (v0 > 0) {
                return 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::compute_reserving_fee_rate(arg1, vault_utilization<T0>(arg0, arg2), v0)
            };
        };
        0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::rate::zero()
    }

    public fun vault_enabled<T0>(arg0: &Vault<T0>) : bool {
        arg0.enabled
    }

    public fun vault_liquidity_amount<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.liquidity)
    }

    public fun vault_price_config<T0>(arg0: &Vault<T0>) : &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPriceConfig {
        &arg0.price_config
    }

    public fun vault_reserved_amount<T0>(arg0: &Vault<T0>) : u64 {
        arg0.reserved_amount
    }

    public fun vault_reserving_fee_model<T0>(arg0: &Vault<T0>) : &0x2::object::ID {
        &arg0.reserving_fee_model
    }

    public fun vault_supply_amount<T0>(arg0: &Vault<T0>) : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal {
        0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::add(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::from_u64(0x2::balance::value<T0>(&arg0.liquidity) + arg0.reserved_amount), arg0.unrealised_reserving_fee_amount)
    }

    public fun vault_unrealised_reserving_fee_amount<T0>(arg0: &Vault<T0>, arg1: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::rate::Rate) : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal {
        0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::add(arg0.unrealised_reserving_fee_amount, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::mul_with_rate(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::from_u64(arg0.reserved_amount), arg1))
    }

    public fun vault_utilization<T0>(arg0: &Vault<T0>, arg1: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal) : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::rate::Rate {
        if (0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::is_zero(&arg1)) {
            0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::rate::zero()
        } else {
            0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::to_rate(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::div(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::from_u64(arg0.reserved_amount), arg1))
        }
    }

    public fun vault_weight<T0>(arg0: &Vault<T0>) : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal {
        arg0.weight
    }

    public(friend) fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::model::RebaseFeeModel, arg2: &0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::AggPrice, arg3: u64, arg4: u64, arg5: u64, arg6: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg7: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg8: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal, arg9: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::Decimal) : 0x2::balance::Balance<T0> {
        assert!(arg0.enabled, 1);
        assert!(arg3 > 0, 10);
        let v0 = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::mul_with_rate(arg6, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::to_rate(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::div(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::from_u64(arg3), 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::from_u64(arg5))));
        assert!(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::le(&v0, &arg7), 2);
        let v1 = 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::floor_u64(0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::agg_price::value_to_coins(arg2, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::sub(v0, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::mul_with_rate(v0, compute_rebase_fee_rate(arg1, false, 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::sub(arg7, v0), 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::decimal::sub(arg8, v0), arg0.weight, arg9)))));
        assert!(v1 <= 0x2::balance::value<T0>(&arg0.liquidity), 3);
        let v2 = 0x2::balance::split<T0>(&mut arg0.liquidity, v1);
        assert!(0x2::balance::value<T0>(&v2) >= arg4, 12);
        v2
    }

    // decompiled from Move bytecode v6
}

