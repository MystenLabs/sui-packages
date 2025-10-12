module 0xd3865c0c364b0039ce2d36d9c801ada888c3a70c1372623e402baff5528780e9::obligation_query {
    struct ObligationData has copy, drop {
        emode_group_id: u8,
        borrows: vector<0xd3865c0c364b0039ce2d36d9c801ada888c3a70c1372623e402baff5528780e9::types::AssetBorrow>,
        deposits: vector<0xd3865c0c364b0039ce2d36d9c801ada888c3a70c1372623e402baff5528780e9::types::AssetDeposit>,
    }

    public fun get_obligation_assets<T0>(arg0: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg1: 0x2::object::ID) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        let v0 = 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::borrow_obligation<T0>(arg0, arg1);
        (0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::obligation::debt_types<T0>(v0), 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::obligation::deposit_types<T0>(v0))
    }

    public fun get_obligation_detail<T0>(arg0: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg1: 0x2::object::ID, arg2: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg4: &0x2::clock::Clock) : ObligationData {
        let v0 = 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::obligation::deposit_types<T0>(v0);
        let v3 = 0x1::vector::empty<0xd3865c0c364b0039ce2d36d9c801ada888c3a70c1372623e402baff5528780e9::types::AssetDeposit>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v1);
            0x1::vector::push_back<0xd3865c0c364b0039ce2d36d9c801ada888c3a70c1372623e402baff5528780e9::types::AssetDeposit>(&mut v3, 0xd3865c0c364b0039ce2d36d9c801ada888c3a70c1372623e402baff5528780e9::types::new_asset_collateral_from_ctoken(v4, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::obligation::ctoken_amount_by_coin<T0>(v0, v4), 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::value::get_price(arg3, v4, arg4), 0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::decimals(arg2, v4), 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::reserve::exchange_rate<T0>(0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::reserve_by_type<T0>(arg0, v4))));
            v1 = v1 + 1;
        };
        v1 = 0;
        let v5 = 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::obligation::debt_types<T0>(v0);
        let v6 = 0x1::vector::empty<0xd3865c0c364b0039ce2d36d9c801ada888c3a70c1372623e402baff5528780e9::types::AssetBorrow>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
            let v7 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v5, v1);
            let v8 = 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::obligation::debt<T0>(v0, v7);
            0x1::vector::push_back<0xd3865c0c364b0039ce2d36d9c801ada888c3a70c1372623e402baff5528780e9::types::AssetBorrow>(&mut v6, 0xd3865c0c364b0039ce2d36d9c801ada888c3a70c1372623e402baff5528780e9::types::new_asset_borrow(v7, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::floor(0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::debt::debt(v8, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::borrow_index::value(0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::reserve::borrow_index<T0>(0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::reserve_by_type<T0>(arg0, v7))))), 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::value::get_price(arg3, v7, arg4), 0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::decimals(arg2, v7), *0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::debt::borrow_index(v8)));
            v1 = v1 + 1;
        };
        ObligationData{
            emode_group_id : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::obligation::emode_group<T0>(v0),
            borrows        : v6,
            deposits       : v3,
        }
    }

    // decompiled from Move bytecode v6
}

