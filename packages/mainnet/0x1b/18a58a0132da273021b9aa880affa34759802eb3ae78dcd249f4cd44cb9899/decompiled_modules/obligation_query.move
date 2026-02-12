module 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::obligation_query {
    struct ObligationData has copy, drop {
        emode_group_id: u8,
        borrows: vector<0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::query_types::AssetBorrow>,
        deposits: vector<0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::query_types::AssetDeposit>,
    }

    public fun get_obligation_assets<T0>(arg0: &0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::Market<T0>, arg1: 0x2::object::ID) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        let v0 = 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::borrow_obligation<T0>(arg0, arg1);
        (0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::obligation::debt_types<T0>(v0), 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::obligation::deposit_types<T0>(v0))
    }

    public fun get_obligation_detail<T0>(arg0: &0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::Market<T0>, arg1: 0x2::object::ID, arg2: &0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1a0736fb2df41236bd00010023e95f2503bed82339e54f13c0b4c032e69697ec::x_oracle::XOracle, arg4: &0x2::clock::Clock) : ObligationData {
        let v0 = 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::obligation::deposit_types<T0>(v0);
        let v3 = 0x1::vector::empty<0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::query_types::AssetDeposit>();
        let v4 = 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::emode::get_oracle_base_token(0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::emode::borrow_emode_group(0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::emode_registry<T0>(arg0), 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::obligation::emode_group<T0>(v0)));
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v1);
            0x1::vector::push_back<0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::query_types::AssetDeposit>(&mut v3, 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::query_types::new_asset_collateral_from_ctoken(v5, 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::obligation::ctoken_amount_by_coin<T0>(v0, v5), 0x1a0736fb2df41236bd00010023e95f2503bed82339e54f13c0b4c032e69697ec::user_oracle::get_price(arg3, v5, v4, arg4), 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::coin_decimals_registry::decimals(arg2, v5), 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::reserve::exchange_rate<T0>(0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::reserve_by_type<T0>(arg0, v5))));
            v1 = v1 + 1;
        };
        v1 = 0;
        let v6 = 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::obligation::debt_types<T0>(v0);
        let v7 = 0x1::vector::empty<0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::query_types::AssetBorrow>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v6)) {
            let v8 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v6, v1);
            let v9 = 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::obligation::debt<T0>(v0, v8);
            0x1::vector::push_back<0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::query_types::AssetBorrow>(&mut v7, 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::query_types::new_asset_borrow(v8, 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::floor(0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::debt::debt(v9, 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::borrow_index::value(0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::reserve::borrow_index<T0>(0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::reserve_by_type<T0>(arg0, v8))))), 0x1a0736fb2df41236bd00010023e95f2503bed82339e54f13c0b4c032e69697ec::user_oracle::get_price(arg3, v8, v4, arg4), 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::coin_decimals_registry::decimals(arg2, v8), *0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::debt::borrow_index(v9)));
            v1 = v1 + 1;
        };
        ObligationData{
            emode_group_id : 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::obligation::emode_group<T0>(v0),
            borrows        : v7,
            deposits       : v3,
        }
    }

    // decompiled from Move bytecode v6
}

