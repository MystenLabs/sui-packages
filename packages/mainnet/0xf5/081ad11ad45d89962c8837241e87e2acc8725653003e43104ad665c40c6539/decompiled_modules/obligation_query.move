module 0xf5081ad11ad45d89962c8837241e87e2acc8725653003e43104ad665c40c6539::obligation_query {
    struct ObligationData has copy, drop {
        borrows: vector<0xf5081ad11ad45d89962c8837241e87e2acc8725653003e43104ad665c40c6539::types::AssetBorrow>,
        deposits: vector<0xf5081ad11ad45d89962c8837241e87e2acc8725653003e43104ad665c40c6539::types::AssetDeposit>,
    }

    public fun get_obligation_assets<T0>(arg0: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::Market<T0>, arg1: 0x2::object::ID) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        let v0 = 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::borrow_obligation<T0>(arg0, arg1);
        (0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::obligation::debt_types<T0>(v0), 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::obligation::deposit_types<T0>(v0))
    }

    public fun get_obligation_detail<T0>(arg0: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::Market<T0>, arg1: 0x2::object::ID, arg2: &0xc17d1d88270b8fabfc423a8000c21a8d265b356b83bc2df9418c55560803ad3a::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xcd9847dcdef37af236b3c6e3fe953a886e53daff970697c4db4414c15723f9f3::x_oracle::XOracle, arg4: &0x2::clock::Clock) : ObligationData {
        let v0 = 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::obligation::deposit_types<T0>(v0);
        let v3 = 0x1::vector::empty<0xf5081ad11ad45d89962c8837241e87e2acc8725653003e43104ad665c40c6539::types::AssetDeposit>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v1);
            0x1::vector::push_back<0xf5081ad11ad45d89962c8837241e87e2acc8725653003e43104ad665c40c6539::types::AssetDeposit>(&mut v3, 0xf5081ad11ad45d89962c8837241e87e2acc8725653003e43104ad665c40c6539::types::new_asset_collateral_from_ctoken(v4, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::obligation::ctoken_amount_by_coin<T0>(v0, v4), 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::value::get_price(arg3, v4, arg4), 0xc17d1d88270b8fabfc423a8000c21a8d265b356b83bc2df9418c55560803ad3a::coin_decimals_registry::decimals(arg2, v4), 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::reserve::exchange_rate<T0>(0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::reserve_by_type<T0>(arg0, v4))));
            v1 = v1 + 1;
        };
        v1 = 0;
        let v5 = 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::obligation::debt_types<T0>(v0);
        let v6 = 0x1::vector::empty<0xf5081ad11ad45d89962c8837241e87e2acc8725653003e43104ad665c40c6539::types::AssetBorrow>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
            let v7 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v5, v1);
            let v8 = 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::obligation::debt<T0>(v0, v7);
            0x1::vector::push_back<0xf5081ad11ad45d89962c8837241e87e2acc8725653003e43104ad665c40c6539::types::AssetBorrow>(&mut v6, 0xf5081ad11ad45d89962c8837241e87e2acc8725653003e43104ad665c40c6539::types::new_asset_borrow(v7, 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::floor(0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::debt::debt(v8, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::borrow_index::value(0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::reserve::borrow_index<T0>(0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::reserve_by_type<T0>(arg0, v7))))), 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::value::get_price(arg3, v7, arg4), 0xc17d1d88270b8fabfc423a8000c21a8d265b356b83bc2df9418c55560803ad3a::coin_decimals_registry::decimals(arg2, v7), *0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::debt::borrow_index(v8)));
            v1 = v1 + 1;
        };
        ObligationData{
            borrows  : v6,
            deposits : v3,
        }
    }

    // decompiled from Move bytecode v6
}

