module 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::obligation_query {
    struct ObligationData has copy, drop {
        emode_group_id: u8,
        borrows: vector<0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::query_types::AssetBorrow>,
        deposits: vector<0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::query_types::AssetDeposit>,
    }

    public fun get_obligation_assets<T0>(arg0: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg1: 0x2::object::ID) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        let v0 = 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::borrow_obligation<T0>(arg0, arg1);
        (0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::obligation::debt_types<T0>(v0), 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::obligation::deposit_types<T0>(v0))
    }

    public fun get_obligation_detail<T0>(arg0: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg1: 0x2::object::ID, arg2: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::x_oracle::XOracle, arg4: &0x2::clock::Clock) : ObligationData {
        let v0 = 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::obligation::deposit_types<T0>(v0);
        let v3 = 0x1::vector::empty<0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::query_types::AssetDeposit>();
        let v4 = 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::emode::get_oracle_base_token(0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::emode::borrow_emode_group(0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::emode_registry<T0>(arg0), 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::obligation::emode_group<T0>(v0)));
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v1);
            0x1::vector::push_back<0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::query_types::AssetDeposit>(&mut v3, 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::query_types::new_asset_collateral_from_ctoken(v5, 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::obligation::ctoken_amount_by_coin<T0>(v0, v5), 0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::user_oracle::get_price(arg3, v5, v4, arg4), 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::coin_decimals_registry::decimals(arg2, v5), 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::reserve::exchange_rate<T0>(0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::reserve_by_type<T0>(arg0, v5))));
            v1 = v1 + 1;
        };
        v1 = 0;
        let v6 = 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::obligation::debt_types<T0>(v0);
        let v7 = 0x1::vector::empty<0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::query_types::AssetBorrow>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v6)) {
            let v8 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v6, v1);
            let v9 = 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::obligation::debt<T0>(v0, v8);
            0x1::vector::push_back<0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::query_types::AssetBorrow>(&mut v7, 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::query_types::new_asset_borrow(v8, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::floor(0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::debt::debt(v9, 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::borrow_index::value(0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::reserve::borrow_index<T0>(0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::reserve_by_type<T0>(arg0, v8))))), 0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::user_oracle::get_price(arg3, v8, v4, arg4), 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::coin_decimals_registry::decimals(arg2, v8), *0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::debt::borrow_index(v9)));
            v1 = v1 + 1;
        };
        ObligationData{
            emode_group_id : 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::obligation::emode_group<T0>(v0),
            borrows        : v7,
            deposits       : v3,
        }
    }

    // decompiled from Move bytecode v6
}

