module 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market_query {
    struct EModeInfo has copy, drop {
        asset: 0x1::type_name::TypeName,
        oracle_base_token: 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::BaseToken,
        collateral_factor: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal,
        liquidation_factor: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal,
        liquidation_incentive: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal,
        borrow_weight: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal,
        max_borrow_amount: u64,
        current_borrow_amount: u64,
        flash_loan_fee_rate: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal,
        deposit_limiter: 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::limiter::RateLimitUsage,
        borrow_limiter: 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::limiter::RateLimitUsage,
    }

    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::interest::InterestModel,
        utilization_rate: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        liquidation_paused: bool,
        flash_loan_paused: bool,
        reserve: u64,
        asset_setting: 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::asset::AssetConfig,
        deposit_usage: 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::query_types::AssetDeposit,
        borrow_usage: 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::query_types::AssetBorrow,
    }

    public fun get_asset_market_overview<T0>(arg0: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : AssetData {
        let v0 = 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::from_quotient(arg3, arg4);
        let v1 = 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::asset_by_type<T0>(arg0, arg1);
        let v2 = 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::reserve_by_type<T0>(arg0, arg1);
        let v3 = 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::coin_decimals_registry::decimals(arg2, arg1);
        let v4 = 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::reserve::calculate_borrow_index<T0>(v2, 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::interest::calc_interest(0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::asset::interest_model<T0>(v1), 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::reserve::util_rate<T0>(v2)), 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::value::clock_now(arg5));
        AssetData{
            coin_type          : arg1,
            interest_model     : *0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::asset::interest_model<T0>(v1),
            utilization_rate   : 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::reserve::util_rate<T0>(v2),
            borrow_paused      : 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::asset::borrow_paused<T0>(v1),
            deposit_paused     : 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::asset::deposit_paused<T0>(v1),
            withdraw_paused    : 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::asset::withdraw_paused<T0>(v1),
            liquidation_paused : 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::asset::liquidation_paused<T0>(v1),
            flash_loan_paused  : 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::asset::flash_loan_paused<T0>(v1),
            reserve            : 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::reserve::protocol_reserve<T0>(v2),
            asset_setting      : *0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::asset::asset_config<T0>(v1),
            deposit_usage      : 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::query_types::new_asset_deposit(arg1, false, 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::floor(0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::reserve::cash_plus_borrows_minus_reserves<T0>(v2)), v0, v3, 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::reserve::exchange_rate<T0>(v2)),
            borrow_usage       : 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::query_types::new_asset_borrow(arg1, 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::floor(0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::div(0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::mul(*0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::reserve::debt<T0>(v2), v4), 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::borrow_index::value(0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::reserve::borrow_index<T0>(v2)))), v0, v3, v4),
        }
    }

    public fun get_asset_market_rates<T0>(arg0: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : vector<0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal> {
        let v0 = 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::reserve_by_type<T0>(arg0, arg1);
        let v1 = 0x1::vector::empty<0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal>();
        let v2 = &mut v1;
        0x1::vector::push_back<0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal>(v2, 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::reserve::exchange_rate<T0>(v0));
        0x1::vector::push_back<0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal>(v2, 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::reserve::calculate_borrow_index<T0>(v0, 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::interest::calc_interest(0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::asset::interest_model<T0>(0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::asset_by_type<T0>(arg0, arg1)), 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::reserve::util_rate<T0>(v0)), 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::value::clock_now(arg2)));
        v1
    }

    public fun get_market_emode_group_overview<T0>(arg0: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::Market<T0>, arg1: u8, arg2: vector<0x1::type_name::TypeName>, arg3: &0x2::clock::Clock) : vector<EModeInfo> {
        let v0 = 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::emode_registry<T0>(arg0);
        0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::ensure_group_exists(v0, arg1);
        let v1 = 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::borrow_emode_group(v0, arg1);
        let v2 = 0;
        let v3 = 0x1::vector::empty<EModeInfo>();
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg2, v2);
            let v5 = 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::borrow_emode(v1, v4);
            let (v6, v7) = 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::limiter_usage(v5, 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::value::clock_now(arg3));
            let v8 = EModeInfo{
                asset                 : v4,
                oracle_base_token     : 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::get_oracle_base_token(v1),
                collateral_factor     : 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::collateral_factor(0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::collateral(v5)),
                liquidation_factor    : 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::liquidation_factor(0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::collateral(v5)),
                liquidation_incentive : 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::liquidation_incentive(0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::collateral(v5)),
                borrow_weight         : 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::borrow_weight(0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::borrow(v5)),
                max_borrow_amount     : 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::max_borrow_amount(0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::borrow(v5)),
                current_borrow_amount : 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::floor(0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::borrow_amount(0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::borrow_emode_group(0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::emode_registry<T0>(arg0), arg1), v4)),
                flash_loan_fee_rate   : 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::fee_rate(0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::emode::flash_loan(v5)),
                deposit_limiter       : v6,
                borrow_limiter        : v7,
            };
            0x1::vector::push_back<EModeInfo>(&mut v3, v8);
            v2 = v2 + 1;
        };
        v3
    }

    // decompiled from Move bytecode v7
}

