module 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market_query {
    struct EModeInfo has copy, drop {
        asset: 0x1::type_name::TypeName,
        oracle_base_token: 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::BaseToken,
        collateral_factor: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal,
        liquidation_factor: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal,
        liquidation_incentive: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal,
        borrow_weight: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal,
        max_borrow_amount: u64,
        current_borrow_amount: u64,
        flash_loan_fee_rate: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal,
        deposit_limiter: 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::limiter::RateLimitUsage,
        borrow_limiter: 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::limiter::RateLimitUsage,
    }

    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::interest::InterestModel,
        utilization_rate: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        liquidation_paused: bool,
        flash_loan_paused: bool,
        reserve: u64,
        asset_setting: 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::AssetConfig,
        deposit_usage: 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::query_types::AssetDeposit,
        borrow_usage: 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::query_types::AssetBorrow,
    }

    public fun get_asset_market_overview<T0>(arg0: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : AssetData {
        let v0 = 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::from_quotient(arg3, arg4);
        let v1 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::asset_by_type<T0>(arg0, arg1);
        let v2 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::reserve_by_type<T0>(arg0, arg1);
        let v3 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::coin_decimals_registry::decimals(arg2, arg1);
        let v4 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::reserve::calculate_borrow_index<T0>(v2, 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::interest::calc_interest(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::interest_model<T0>(v1), 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::reserve::util_rate<T0>(v2)), 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::value::clock_now(arg5));
        AssetData{
            coin_type          : arg1,
            interest_model     : *0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::interest_model<T0>(v1),
            utilization_rate   : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::reserve::util_rate<T0>(v2),
            borrow_paused      : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::borrow_paused<T0>(v1),
            deposit_paused     : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::deposit_paused<T0>(v1),
            withdraw_paused    : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::withdraw_paused<T0>(v1),
            liquidation_paused : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::liquidation_paused<T0>(v1),
            flash_loan_paused  : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::flash_loan_paused<T0>(v1),
            reserve            : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::reserve::protocol_reserve<T0>(v2),
            asset_setting      : *0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::asset_config<T0>(v1),
            deposit_usage      : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::query_types::new_asset_deposit(arg1, false, 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::floor(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::reserve::cash_plus_borrows_minus_reserves<T0>(v2)), v0, v3, 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::reserve::exchange_rate<T0>(v2)),
            borrow_usage       : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::query_types::new_asset_borrow(arg1, 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::floor(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::div(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::mul(*0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::reserve::debt<T0>(v2), v4), 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::borrow_index::value(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::reserve::borrow_index<T0>(v2)))), v0, v3, v4),
        }
    }

    public fun get_asset_market_rates<T0>(arg0: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : vector<0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal> {
        let v0 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::reserve_by_type<T0>(arg0, arg1);
        let v1 = 0x1::vector::empty<0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal>();
        let v2 = &mut v1;
        0x1::vector::push_back<0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal>(v2, 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::reserve::exchange_rate<T0>(v0));
        0x1::vector::push_back<0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal>(v2, 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::reserve::calculate_borrow_index<T0>(v0, 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::interest::calc_interest(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::interest_model<T0>(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::asset_by_type<T0>(arg0, arg1)), 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::reserve::util_rate<T0>(v0)), 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::value::clock_now(arg2)));
        v1
    }

    public fun get_market_emode_group_overview<T0>(arg0: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg1: u8, arg2: vector<0x1::type_name::TypeName>, arg3: &0x2::clock::Clock) : vector<EModeInfo> {
        let v0 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::emode_registry<T0>(arg0);
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::ensure_group_exists(v0, arg1);
        let v1 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::borrow_emode_group(v0, arg1);
        let v2 = 0;
        let v3 = 0x1::vector::empty<EModeInfo>();
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg2, v2);
            let v5 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::borrow_emode(v1, v4);
            let (v6, v7) = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::limiter_usage(v5, 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::value::clock_now(arg3));
            let v8 = EModeInfo{
                asset                 : v4,
                oracle_base_token     : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::get_oracle_base_token(v1),
                collateral_factor     : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::collateral_factor(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::collateral(v5)),
                liquidation_factor    : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::liquidation_factor(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::collateral(v5)),
                liquidation_incentive : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::liquidation_incentive(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::collateral(v5)),
                borrow_weight         : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::borrow_weight(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::borrow(v5)),
                max_borrow_amount     : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::max_borrow_amount(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::borrow(v5)),
                current_borrow_amount : 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::floor(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::borrow_amount(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::borrow_emode_group(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::emode_registry<T0>(arg0), arg1), v4)),
                flash_loan_fee_rate   : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::fee_rate(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::emode::flash_loan(v5)),
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

