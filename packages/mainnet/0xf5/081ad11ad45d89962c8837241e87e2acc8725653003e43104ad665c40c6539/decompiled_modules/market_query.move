module 0xf5081ad11ad45d89962c8837241e87e2acc8725653003e43104ad665c40c6539::market_query {
    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::interest::InterestModel,
        utilization_rate: 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal,
        collateral_setting: 0x1::option::Option<0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::Collateral>,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        liquidation_paused: bool,
        flash_loan_paused: bool,
        reserve: u64,
        deposit_rate_limit: 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::limiter::RateLimitUsage,
        borrow_rate_limit: 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::limiter::RateLimitUsage,
        asset_setting: 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::BorrowConfig,
        deposit_usage: 0xf5081ad11ad45d89962c8837241e87e2acc8725653003e43104ad665c40c6539::types::AssetDeposit,
        borrow_usage: 0xf5081ad11ad45d89962c8837241e87e2acc8725653003e43104ad665c40c6539::types::AssetBorrow,
    }

    struct MarketData has copy, drop {
        assets: vector<AssetData>,
    }

    public fun get_asset_detail<T0>(arg0: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0xc17d1d88270b8fabfc423a8000c21a8d265b356b83bc2df9418c55560803ad3a::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xcd9847dcdef37af236b3c6e3fe953a886e53daff970697c4db4414c15723f9f3::x_oracle::XOracle, arg4: &0x2::clock::Clock) : AssetData {
        let v0 = 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::asset_by_type<T0>(arg0, arg1);
        let v1 = 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::reserve_by_type<T0>(arg0, arg1);
        let v2 = 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::value::get_price(arg3, arg1, arg4);
        let v3 = 0xc17d1d88270b8fabfc423a8000c21a8d265b356b83bc2df9418c55560803ad3a::coin_decimals_registry::decimals(arg2, arg1);
        let v4 = 0xf5081ad11ad45d89962c8837241e87e2acc8725653003e43104ad665c40c6539::types::new_asset_borrow(arg1, 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::floor(*0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::reserve::debt<T0>(v1)), v2, v3, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::borrow_index::value(0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::reserve::borrow_index<T0>(v1)));
        let (v5, v6) = 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::rate_limit_usage<T0>(arg0, arg1, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::value::clock_now(arg4));
        let v7 = if (0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::can_be_collateral<T0>(v0)) {
            0x1::option::some<0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::Collateral>(*0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::collateral_setting<T0>(v0))
        } else {
            0x1::option::none<0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::Collateral>()
        };
        AssetData{
            coin_type          : arg1,
            interest_model     : *0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::interest_model<T0>(v0),
            utilization_rate   : 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::reserve::util_rate<T0>(v1),
            collateral_setting : v7,
            borrow_paused      : 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::borrow_paused<T0>(v0),
            deposit_paused     : 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::deposit_paused<T0>(v0),
            withdraw_paused    : 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::withdraw_paused<T0>(v0),
            liquidation_paused : 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::liquidation_paused<T0>(v0),
            flash_loan_paused  : 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::flash_loan_paused<T0>(v0),
            reserve            : 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::reserve::protocol_reserve<T0>(v1),
            deposit_rate_limit : v5,
            borrow_rate_limit  : v6,
            asset_setting      : *0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::borrow_setting<T0>(v0),
            deposit_usage      : 0xf5081ad11ad45d89962c8837241e87e2acc8725653003e43104ad665c40c6539::types::new_asset_deposit(arg1, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::can_be_collateral<T0>(v0), 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::floor(0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::reserve::cash_plus_borrows_minus_reserves<T0>(v1)), v2, v3, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::reserve::exchange_rate<T0>(v1)),
            borrow_usage       : v4,
        }
    }

    public fun get_market_detail<T0>(arg0: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::Market<T0>, arg1: &0xc17d1d88270b8fabfc423a8000c21a8d265b356b83bc2df9418c55560803ad3a::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0xcd9847dcdef37af236b3c6e3fe953a886e53daff970697c4db4414c15723f9f3::x_oracle::XOracle, arg3: &0x2::clock::Clock) : MarketData {
        let v0 = 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::supported_assets<T0>(arg0);
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

