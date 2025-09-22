module 0x11fa2e616be1b72476c2f97f5dc945e14e88ab014b8e10900d9cb8a02fa269a3::market_query {
    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::interest::InterestModel,
        utilization_rate: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal,
        collateral_setting: 0x1::option::Option<0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::asset::Collateral>,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        liquidation_paused: bool,
        flash_loan_paused: bool,
        reserve: u64,
        deposit_rate_limit: 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::limiter::RateLimitUsage,
        borrow_rate_limit: 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::limiter::RateLimitUsage,
        asset_setting: 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::asset::BorrowConfig,
        deposit_usage: 0x11fa2e616be1b72476c2f97f5dc945e14e88ab014b8e10900d9cb8a02fa269a3::types::AssetDeposit,
        borrow_usage: 0x11fa2e616be1b72476c2f97f5dc945e14e88ab014b8e10900d9cb8a02fa269a3::types::AssetBorrow,
    }

    struct MarketData has copy, drop {
        assets: vector<AssetData>,
    }

    public fun get_asset_detail<T0>(arg0: &0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg4: &0x2::clock::Clock) : AssetData {
        let v0 = 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::asset_by_type<T0>(arg0, arg1);
        let v1 = 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::reserve_by_type<T0>(arg0, arg1);
        let v2 = 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::value::get_price(arg3, arg1, arg4);
        let v3 = 0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::decimals(arg2, arg1);
        let v4 = 0x11fa2e616be1b72476c2f97f5dc945e14e88ab014b8e10900d9cb8a02fa269a3::types::new_asset_borrow(arg1, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::floor(*0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::reserve::debt<T0>(v1)), v2, v3, 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::borrow_index::value(0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::reserve::borrow_index<T0>(v1)));
        let (v5, v6) = 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::rate_limit_usage<T0>(arg0, arg1, 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::value::clock_now(arg4));
        let v7 = if (0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::asset::can_be_collateral<T0>(v0)) {
            0x1::option::some<0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::asset::Collateral>(*0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::asset::collateral_setting<T0>(v0))
        } else {
            0x1::option::none<0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::asset::Collateral>()
        };
        AssetData{
            coin_type          : arg1,
            interest_model     : *0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::asset::interest_model<T0>(v0),
            utilization_rate   : 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::reserve::util_rate<T0>(v1),
            collateral_setting : v7,
            borrow_paused      : 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::asset::borrow_paused<T0>(v0),
            deposit_paused     : 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::asset::deposit_paused<T0>(v0),
            withdraw_paused    : 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::asset::withdraw_paused<T0>(v0),
            liquidation_paused : 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::asset::liquidation_paused<T0>(v0),
            flash_loan_paused  : 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::asset::flash_loan_paused<T0>(v0),
            reserve            : 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::reserve::protocol_reserve<T0>(v1),
            deposit_rate_limit : v5,
            borrow_rate_limit  : v6,
            asset_setting      : *0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::asset::borrow_setting<T0>(v0),
            deposit_usage      : 0x11fa2e616be1b72476c2f97f5dc945e14e88ab014b8e10900d9cb8a02fa269a3::types::new_asset_deposit(arg1, 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::asset::can_be_collateral<T0>(v0), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::floor(0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::reserve::cash_plus_borrows_minus_reserves<T0>(v1)), v2, v3, 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::reserve::exchange_rate<T0>(v1)),
            borrow_usage       : v4,
        }
    }

    public fun get_market_detail<T0>(arg0: &0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::Market<T0>, arg1: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg3: &0x2::clock::Clock) : MarketData {
        let v0 = 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::supported_assets<T0>(arg0);
        let v1 = 0x1::vector::empty<AssetData>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            0x1::vector::push_back<AssetData>(&mut v1, get_asset_detail<T0>(arg0, *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2), arg1, arg2, arg3));
            v2 = v2 + 1;
        };
        MarketData{assets: v1}
    }

    // decompiled from Move bytecode v6
}

