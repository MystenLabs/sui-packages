module 0xeb89706ae10184c95ef5e7c8502e1eeaec7a23e5f41a92c9213f7cdf2b72f3e1::market_query {
    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::interest::InterestModel,
        utilization_rate: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
        collateral_setting: 0x1::option::Option<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Collateral>,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        asset_setting: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::BorrowConfig,
        deposit_usage: 0xeb89706ae10184c95ef5e7c8502e1eeaec7a23e5f41a92c9213f7cdf2b72f3e1::types::AssetDeposit,
        borrow_usage: 0xeb89706ae10184c95ef5e7c8502e1eeaec7a23e5f41a92c9213f7cdf2b72f3e1::types::AssetBorrow,
    }

    struct MarketData has copy, drop {
        assets: vector<AssetData>,
    }

    public fun get_asset_detail<T0>(arg0: &0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg4: &0x2::clock::Clock) : AssetData {
        let v0 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::asset_by_type<T0>(arg0, arg1);
        let v1 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::reserve_by_type<T0>(arg0, arg1);
        let v2 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::value::get_price(arg3, arg1, arg4);
        let v3 = 0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::decimals(arg2, arg1);
        let v4 = if (0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::can_be_collateral<T0>(v0)) {
            0x1::option::some<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Collateral>(*0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::collateral_setting<T0>(v0))
        } else {
            0x1::option::none<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Collateral>()
        };
        AssetData{
            coin_type          : arg1,
            interest_model     : *0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::interest_model<T0>(v0),
            utilization_rate   : 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::util_rate<T0>(v1),
            collateral_setting : v4,
            borrow_paused      : 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::borrow_paused<T0>(v0),
            deposit_paused     : 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::deposit_paused<T0>(v0),
            withdraw_paused    : 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::withdraw_paused<T0>(v0),
            asset_setting      : *0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::borrow_setting<T0>(v0),
            deposit_usage      : 0xeb89706ae10184c95ef5e7c8502e1eeaec7a23e5f41a92c9213f7cdf2b72f3e1::types::new_asset_deposit(arg1, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::can_be_collateral<T0>(v0), 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::floor(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::cash_plus_borrows_minus_reserves<T0>(v1)), v2, v3, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::exchange_rate<T0>(v1)),
            borrow_usage       : 0xeb89706ae10184c95ef5e7c8502e1eeaec7a23e5f41a92c9213f7cdf2b72f3e1::types::new_asset_borrow(arg1, 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::floor(*0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::debt<T0>(v1)), v2, v3, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::borrow_index::value(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::borrow_index<T0>(v1))),
        }
    }

    public fun get_market_detail<T0>(arg0: &0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg3: &0x2::clock::Clock) : MarketData {
        let v0 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::supported_assets<T0>(arg0);
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

