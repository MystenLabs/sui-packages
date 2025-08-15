module 0x8d0124d7585da1882bfd27be0179d41fcc7ecfe6732b2bf2216adf886b68b1b9::market_query {
    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::interest::InterestModel,
        utilization_rate: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal,
        collateral_setting: 0x1::option::Option<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::Collateral>,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        asset_setting: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::BorrowConfig,
        deposit_usage: 0x8d0124d7585da1882bfd27be0179d41fcc7ecfe6732b2bf2216adf886b68b1b9::types::AssetDeposit,
        borrow_usage: 0x8d0124d7585da1882bfd27be0179d41fcc7ecfe6732b2bf2216adf886b68b1b9::types::AssetBorrow,
    }

    struct MarketData has copy, drop {
        assets: vector<AssetData>,
    }

    public fun get_asset_detail<T0>(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0x6a79a9f82463e3c554cd5106e3878882c40568d264f0d43002bc4e9eba025159::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::x_oracle::XOracle, arg4: &0x2::clock::Clock) : AssetData {
        let v0 = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::asset_by_type<T0>(arg0, arg1);
        let v1 = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::reserve_by_type<T0>(arg0, arg1);
        let v2 = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::value::get_price(arg3, arg1, arg4);
        let v3 = 0x6a79a9f82463e3c554cd5106e3878882c40568d264f0d43002bc4e9eba025159::coin_decimals_registry::decimals(arg2, arg1);
        let v4 = if (0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::can_be_collateral<T0>(v0)) {
            0x1::option::some<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::Collateral>(*0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::collateral_setting<T0>(v0))
        } else {
            0x1::option::none<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::Collateral>()
        };
        AssetData{
            coin_type          : arg1,
            interest_model     : *0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::interest_model<T0>(v0),
            utilization_rate   : 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::reserve::util_rate<T0>(v1),
            collateral_setting : v4,
            borrow_paused      : 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::borrow_paused<T0>(v0),
            deposit_paused     : 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::deposit_paused<T0>(v0),
            withdraw_paused    : 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::withdraw_paused<T0>(v0),
            asset_setting      : *0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::borrow_setting<T0>(v0),
            deposit_usage      : 0x8d0124d7585da1882bfd27be0179d41fcc7ecfe6732b2bf2216adf886b68b1b9::types::new_asset_deposit(arg1, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::can_be_collateral<T0>(v0), 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::floor(0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::reserve::cash_plus_borrows_minus_reserves<T0>(v1)), v2, v3, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::reserve::exchange_rate<T0>(v1)),
            borrow_usage       : 0x8d0124d7585da1882bfd27be0179d41fcc7ecfe6732b2bf2216adf886b68b1b9::types::new_asset_borrow(arg1, 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::floor(*0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::reserve::debt<T0>(v1)), v2, v3, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::borrow_index::value(0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::reserve::borrow_index<T0>(v1))),
        }
    }

    public fun get_market_detail<T0>(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg1: &0x6a79a9f82463e3c554cd5106e3878882c40568d264f0d43002bc4e9eba025159::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::x_oracle::XOracle, arg3: &0x2::clock::Clock) : MarketData {
        let v0 = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::supported_assets<T0>(arg0);
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

