module 0xe6ad86f194503b03ca2059048a188866f740e945e25ca7bd1ddbe36ed4be505b::obligation_query {
    struct ObligationData has copy, drop {
        borrows: vector<0xe6ad86f194503b03ca2059048a188866f740e945e25ca7bd1ddbe36ed4be505b::types::AssetBorrow>,
        deposits: vector<0xe6ad86f194503b03ca2059048a188866f740e945e25ca7bd1ddbe36ed4be505b::types::AssetDeposit>,
    }

    public fun get_obligation_assets<T0>(arg0: &0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: 0x2::object::ID) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        let v0 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::borrow_obligation<T0>(arg0, arg1);
        (0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::debt_types<T0>(v0), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::deposit_types<T0>(v0))
    }

    public fun get_obligation_detail<T0>(arg0: &0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: 0x2::object::ID, arg2: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg4: &0x2::clock::Clock) : ObligationData {
        let v0 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::deposit_types<T0>(v0);
        let v3 = 0x1::vector::empty<0xe6ad86f194503b03ca2059048a188866f740e945e25ca7bd1ddbe36ed4be505b::types::AssetDeposit>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v1);
            0x1::vector::push_back<0xe6ad86f194503b03ca2059048a188866f740e945e25ca7bd1ddbe36ed4be505b::types::AssetDeposit>(&mut v3, 0xe6ad86f194503b03ca2059048a188866f740e945e25ca7bd1ddbe36ed4be505b::types::new_asset_collateral_from_ctoken(v4, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::ctoken_amount_by_coin<T0>(v0, v4), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::value::get_price(arg3, v4, arg4), 0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::decimals(arg2, v4), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::exchange_rate<T0>(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::reserve_by_type<T0>(arg0, v4))));
            v1 = v1 + 1;
        };
        v1 = 0;
        let v5 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::debt_types<T0>(v0);
        let v6 = 0x1::vector::empty<0xe6ad86f194503b03ca2059048a188866f740e945e25ca7bd1ddbe36ed4be505b::types::AssetBorrow>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
            let v7 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v5, v1);
            let v8 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::debt<T0>(v0, v7);
            0x1::vector::push_back<0xe6ad86f194503b03ca2059048a188866f740e945e25ca7bd1ddbe36ed4be505b::types::AssetBorrow>(&mut v6, 0xe6ad86f194503b03ca2059048a188866f740e945e25ca7bd1ddbe36ed4be505b::types::new_asset_borrow(v7, 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::floor(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::debt::debt(v8, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::borrow_index::value(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::borrow_index<T0>(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::reserve_by_type<T0>(arg0, v7))))), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::value::get_price(arg3, v7, arg4), 0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::decimals(arg2, v7), *0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::debt::borrow_index(v8)));
            v1 = v1 + 1;
        };
        ObligationData{
            borrows  : v6,
            deposits : v3,
        }
    }

    // decompiled from Move bytecode v6
}

