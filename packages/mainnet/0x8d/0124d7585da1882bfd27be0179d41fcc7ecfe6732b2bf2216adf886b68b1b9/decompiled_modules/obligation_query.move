module 0x8d0124d7585da1882bfd27be0179d41fcc7ecfe6732b2bf2216adf886b68b1b9::obligation_query {
    struct ObligationData has copy, drop {
        borrows: vector<0x8d0124d7585da1882bfd27be0179d41fcc7ecfe6732b2bf2216adf886b68b1b9::types::AssetBorrow>,
        deposits: vector<0x8d0124d7585da1882bfd27be0179d41fcc7ecfe6732b2bf2216adf886b68b1b9::types::AssetDeposit>,
    }

    public fun get_obligation_assets<T0>(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg1: 0x2::object::ID) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        let v0 = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::borrow_obligation<T0>(arg0, arg1);
        (0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::debt_types<T0>(v0), 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::deposit_types<T0>(v0))
    }

    public fun get_obligation_detail<T0>(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg1: 0x2::object::ID, arg2: &0x6a79a9f82463e3c554cd5106e3878882c40568d264f0d43002bc4e9eba025159::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::x_oracle::XOracle, arg4: &0x2::clock::Clock) : ObligationData {
        let v0 = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::deposit_types<T0>(v0);
        let v3 = 0x1::vector::empty<0x8d0124d7585da1882bfd27be0179d41fcc7ecfe6732b2bf2216adf886b68b1b9::types::AssetDeposit>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v1);
            0x1::vector::push_back<0x8d0124d7585da1882bfd27be0179d41fcc7ecfe6732b2bf2216adf886b68b1b9::types::AssetDeposit>(&mut v3, 0x8d0124d7585da1882bfd27be0179d41fcc7ecfe6732b2bf2216adf886b68b1b9::types::new_asset_collateral_from_ctoken(v4, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::ctoken_amount_by_coin<T0>(v0, v4), 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::value::get_price(arg3, v4, arg4), 0x6a79a9f82463e3c554cd5106e3878882c40568d264f0d43002bc4e9eba025159::coin_decimals_registry::decimals(arg2, v4), 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::reserve::exchange_rate<T0>(0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::reserve_by_type<T0>(arg0, v4))));
            v1 = v1 + 1;
        };
        v1 = 0;
        let v5 = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::debt_types<T0>(v0);
        let v6 = 0x1::vector::empty<0x8d0124d7585da1882bfd27be0179d41fcc7ecfe6732b2bf2216adf886b68b1b9::types::AssetBorrow>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
            let v7 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v5, v1);
            let v8 = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::debt<T0>(v0, v7);
            0x1::vector::push_back<0x8d0124d7585da1882bfd27be0179d41fcc7ecfe6732b2bf2216adf886b68b1b9::types::AssetBorrow>(&mut v6, 0x8d0124d7585da1882bfd27be0179d41fcc7ecfe6732b2bf2216adf886b68b1b9::types::new_asset_borrow(v7, 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::floor(0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::debt::debt(v8, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::borrow_index::value(0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::reserve::borrow_index<T0>(0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::reserve_by_type<T0>(arg0, v7))))), 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::value::get_price(arg3, v7, arg4), 0x6a79a9f82463e3c554cd5106e3878882c40568d264f0d43002bc4e9eba025159::coin_decimals_registry::decimals(arg2, v7), *0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::debt::borrow_index(v8)));
            v1 = v1 + 1;
        };
        ObligationData{
            borrows  : v6,
            deposits : v3,
        }
    }

    // decompiled from Move bytecode v6
}

