module 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market_query {
    struct EModeInfo has copy, drop {
        asset: 0x1::type_name::TypeName,
        oracle_base_token: 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::BaseToken,
        collateral_factor: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal,
        liquidation_factor: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal,
        liquidation_incentive: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal,
        borrow_weight: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal,
        max_borrow_amount: u64,
        current_borrow_amount: u64,
        flash_loan_fee_rate: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal,
        deposit_limiter: 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::limiter::RateLimitUsage,
        borrow_limiter: 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::limiter::RateLimitUsage,
    }

    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::interest::InterestModel,
        utilization_rate: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        liquidation_paused: bool,
        flash_loan_paused: bool,
        reserve: u64,
        asset_setting: 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::asset::AssetConfig,
        deposit_usage: 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::query_types::AssetDeposit,
        borrow_usage: 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::query_types::AssetBorrow,
    }

    public fun get_asset_market_overview<T0>(arg0: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : AssetData {
        let v0 = 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::from_quotient(arg3, arg4);
        let v1 = 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::asset_by_type<T0>(arg0, arg1);
        let v2 = 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::reserve_by_type<T0>(arg0, arg1);
        let v3 = 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::coin_decimals_registry::decimals(arg2, arg1);
        let v4 = 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::reserve::calculate_borrow_index<T0>(v2, 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::interest::calc_interest(0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::asset::interest_model<T0>(v1), 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::reserve::util_rate<T0>(v2)), 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::value::clock_now(arg5));
        AssetData{
            coin_type          : arg1,
            interest_model     : *0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::asset::interest_model<T0>(v1),
            utilization_rate   : 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::reserve::util_rate<T0>(v2),
            borrow_paused      : 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::asset::borrow_paused<T0>(v1),
            deposit_paused     : 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::asset::deposit_paused<T0>(v1),
            withdraw_paused    : 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::asset::withdraw_paused<T0>(v1),
            liquidation_paused : 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::asset::liquidation_paused<T0>(v1),
            flash_loan_paused  : 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::asset::flash_loan_paused<T0>(v1),
            reserve            : 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::reserve::protocol_reserve<T0>(v2),
            asset_setting      : *0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::asset::asset_config<T0>(v1),
            deposit_usage      : 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::query_types::new_asset_deposit(arg1, false, 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::floor(0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::reserve::cash_plus_borrows_minus_reserves<T0>(v2)), v0, v3, 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::reserve::exchange_rate<T0>(v2)),
            borrow_usage       : 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::query_types::new_asset_borrow(arg1, 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::floor(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::div(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::mul(*0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::reserve::debt<T0>(v2), v4), 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::borrow_index::value(0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::reserve::borrow_index<T0>(v2)))), v0, v3, v4),
        }
    }

    public fun get_asset_market_rates<T0>(arg0: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : vector<0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal> {
        let v0 = 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::reserve_by_type<T0>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal>(v2, 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::reserve::exchange_rate<T0>(v0));
        0x1::vector::push_back<0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal>(v2, 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::reserve::calculate_borrow_index<T0>(v0, 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::interest::calc_interest(0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::asset::interest_model<T0>(0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::asset_by_type<T0>(arg0, arg1)), 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::reserve::util_rate<T0>(v0)), 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::value::clock_now(arg2)));
        v1
    }

    public fun get_market_emode_group_overview<T0>(arg0: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>, arg1: u8, arg2: vector<0x1::type_name::TypeName>, arg3: &0x2::clock::Clock) : vector<EModeInfo> {
        let v0 = 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::emode_registry<T0>(arg0);
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::ensure_group_exists(v0, arg1);
        let v1 = 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::borrow_emode_group(v0, arg1);
        let v2 = 0;
        let v3 = 0x1::vector::empty<EModeInfo>();
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg2, v2);
            let v5 = 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::borrow_emode(v1, v4);
            let (v6, v7) = 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::limiter_usage(v5, 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::value::clock_now(arg3));
            let v8 = EModeInfo{
                asset                 : v4,
                oracle_base_token     : 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::get_oracle_base_token(v1),
                collateral_factor     : 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::collateral_factor(0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::collateral(v5)),
                liquidation_factor    : 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::liquidation_factor(0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::collateral(v5)),
                liquidation_incentive : 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::liquidation_incentive(0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::collateral(v5)),
                borrow_weight         : 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::borrow_weight(0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::borrow(v5)),
                max_borrow_amount     : 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::max_borrow_amount(0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::borrow(v5)),
                current_borrow_amount : 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::floor(0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::borrow_amount(0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::borrow_emode_group(0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::emode_registry<T0>(arg0), arg1), v4)),
                flash_loan_fee_rate   : 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::fee_rate(0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::emode::flash_loan(v5)),
                deposit_limiter       : v6,
                borrow_limiter        : v7,
            };
            0x1::vector::push_back<EModeInfo>(&mut v3, v8);
            v2 = v2 + 1;
        };
        v3
    }

    // decompiled from Move bytecode v6
}

