module 0x69ed386922711ebc68c68d77b8bde2bc03c7293f0c5913aa8eab36920574c112::obligation_query {
    struct ObligationData has copy, drop {
        borrows: vector<0x69ed386922711ebc68c68d77b8bde2bc03c7293f0c5913aa8eab36920574c112::types::AssetBorrow>,
        deposits: vector<0x69ed386922711ebc68c68d77b8bde2bc03c7293f0c5913aa8eab36920574c112::types::AssetDeposit>,
    }

    public fun get_obligation_assets<T0>(arg0: &0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::market::Market<T0>, arg1: 0x2::object::ID) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        let v0 = 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::market::borrow_obligation<T0>(arg0, arg1);
        (0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::obligation::debt_types<T0>(v0), 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::obligation::deposit_types<T0>(v0))
    }

    public fun get_obligation_detail<T0>(arg0: &0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::market::Market<T0>, arg1: 0x2::object::ID, arg2: &0x15afa87bdbd8f62f6523e369f23983ad97a07630c16a71b942c0023396813d87::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::x_oracle::XOracle, arg4: &0x2::clock::Clock) : ObligationData {
        let v0 = 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::obligation::deposit_types<T0>(v0);
        let v3 = 0x1::vector::empty<0x69ed386922711ebc68c68d77b8bde2bc03c7293f0c5913aa8eab36920574c112::types::AssetDeposit>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v1);
            0x1::vector::push_back<0x69ed386922711ebc68c68d77b8bde2bc03c7293f0c5913aa8eab36920574c112::types::AssetDeposit>(&mut v3, 0x69ed386922711ebc68c68d77b8bde2bc03c7293f0c5913aa8eab36920574c112::types::new_asset_collateral_from_ctoken(v4, 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::obligation::ctoken_amount_by_coin<T0>(v0, v4), 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::value::get_price(arg3, v4, arg4), 0x15afa87bdbd8f62f6523e369f23983ad97a07630c16a71b942c0023396813d87::coin_decimals_registry::decimals(arg2, v4), 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::reserve::exchange_rate<T0>(0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::market::reserve_by_type<T0>(arg0, v4))));
            v1 = v1 + 1;
        };
        v1 = 0;
        let v5 = 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::obligation::debt_types<T0>(v0);
        let v6 = 0x1::vector::empty<0x69ed386922711ebc68c68d77b8bde2bc03c7293f0c5913aa8eab36920574c112::types::AssetBorrow>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
            let v7 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v5, v1);
            let v8 = 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::obligation::debt<T0>(v0, v7);
            0x1::vector::push_back<0x69ed386922711ebc68c68d77b8bde2bc03c7293f0c5913aa8eab36920574c112::types::AssetBorrow>(&mut v6, 0x69ed386922711ebc68c68d77b8bde2bc03c7293f0c5913aa8eab36920574c112::types::new_asset_borrow(v7, 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::floor(0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::debt::debt(v8, 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::borrow_index::value(0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::reserve::borrow_index<T0>(0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::market::reserve_by_type<T0>(arg0, v7))))), 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::value::get_price(arg3, v7, arg4), 0x15afa87bdbd8f62f6523e369f23983ad97a07630c16a71b942c0023396813d87::coin_decimals_registry::decimals(arg2, v7), *0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::debt::borrow_index(v8)));
            v1 = v1 + 1;
        };
        ObligationData{
            borrows  : v6,
            deposits : v3,
        }
    }

    // decompiled from Move bytecode v6
}

