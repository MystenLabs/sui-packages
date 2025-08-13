module 0x69ed386922711ebc68c68d77b8bde2bc03c7293f0c5913aa8eab36920574c112::market_query {
    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::interest::InterestModel,
        utilization_rate: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal,
        collateral_setting: 0x1::option::Option<0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::asset::Collateral>,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        asset_setting: 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::asset::BorrowConfig,
        deposit_usage: 0x69ed386922711ebc68c68d77b8bde2bc03c7293f0c5913aa8eab36920574c112::types::AssetDeposit,
        borrow_usage: 0x69ed386922711ebc68c68d77b8bde2bc03c7293f0c5913aa8eab36920574c112::types::AssetBorrow,
    }

    struct MarketData has copy, drop {
        assets: vector<AssetData>,
    }

    public fun get_asset_detail<T0>(arg0: &0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0x15afa87bdbd8f62f6523e369f23983ad97a07630c16a71b942c0023396813d87::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::x_oracle::XOracle, arg4: &0x2::clock::Clock) : AssetData {
        let v0 = 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::market::asset_by_type<T0>(arg0, arg1);
        let v1 = 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::market::reserve_by_type<T0>(arg0, arg1);
        let v2 = 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::value::get_price(arg3, arg1, arg4);
        let v3 = 0x15afa87bdbd8f62f6523e369f23983ad97a07630c16a71b942c0023396813d87::coin_decimals_registry::decimals(arg2, arg1);
        let v4 = if (0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::asset::can_be_collateral<T0>(v0)) {
            0x1::option::some<0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::asset::Collateral>(*0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::asset::collateral_setting<T0>(v0))
        } else {
            0x1::option::none<0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::asset::Collateral>()
        };
        AssetData{
            coin_type          : arg1,
            interest_model     : *0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::asset::interest_model<T0>(v0),
            utilization_rate   : 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::reserve::util_rate<T0>(v1),
            collateral_setting : v4,
            borrow_paused      : 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::asset::borrow_paused<T0>(v0),
            deposit_paused     : 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::asset::deposit_paused<T0>(v0),
            withdraw_paused    : 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::asset::withdraw_paused<T0>(v0),
            asset_setting      : *0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::asset::borrow_setting<T0>(v0),
            deposit_usage      : 0x69ed386922711ebc68c68d77b8bde2bc03c7293f0c5913aa8eab36920574c112::types::new_asset_deposit(arg1, 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::asset::can_be_collateral<T0>(v0), 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::floor(0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::reserve::cash_plus_borrows_minus_reserves<T0>(v1)), v2, v3, 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::reserve::exchange_rate<T0>(v1)),
            borrow_usage       : 0x69ed386922711ebc68c68d77b8bde2bc03c7293f0c5913aa8eab36920574c112::types::new_asset_borrow(arg1, 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::floor(*0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::reserve::debt<T0>(v1)), v2, v3, 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::borrow_index::value(0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::reserve::borrow_index<T0>(v1))),
        }
    }

    public fun get_market_detail<T0>(arg0: &0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::market::Market<T0>, arg1: &0x15afa87bdbd8f62f6523e369f23983ad97a07630c16a71b942c0023396813d87::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::x_oracle::XOracle, arg3: &0x2::clock::Clock) : MarketData {
        let v0 = 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::market::supported_assets<T0>(arg0);
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

