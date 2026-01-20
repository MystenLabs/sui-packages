module 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::obligation_query {
    struct ObligationData has copy, drop {
        emode_group_id: u8,
        borrows: vector<0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::query_types::AssetBorrow>,
        deposits: vector<0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::query_types::AssetDeposit>,
    }

    public fun get_obligation_assets<T0>(arg0: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::Market<T0>, arg1: 0x2::object::ID) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        let v0 = 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::borrow_obligation<T0>(arg0, arg1);
        (0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::obligation::debt_types<T0>(v0), 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::obligation::deposit_types<T0>(v0))
    }

    public fun get_obligation_detail<T0>(arg0: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::Market<T0>, arg1: 0x2::object::ID, arg2: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::XOracle, arg4: &0x2::clock::Clock) : ObligationData {
        let v0 = 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::obligation::deposit_types<T0>(v0);
        let v3 = 0x1::vector::empty<0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::query_types::AssetDeposit>();
        let v4 = 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::emode::get_oracle_base_token(0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::emode::borrow_emode_group(0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::emode_registry<T0>(arg0), 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::obligation::emode_group<T0>(v0)));
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v1);
            0x1::vector::push_back<0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::query_types::AssetDeposit>(&mut v3, 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::query_types::new_asset_collateral_from_ctoken(v5, 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::obligation::ctoken_amount_by_coin<T0>(v0, v5), 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::user_oracle::get_price(arg3, v5, v4, arg4), 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::coin_decimals_registry::decimals(arg2, v5), 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::reserve::exchange_rate<T0>(0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::reserve_by_type<T0>(arg0, v5))));
            v1 = v1 + 1;
        };
        v1 = 0;
        let v6 = 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::obligation::debt_types<T0>(v0);
        let v7 = 0x1::vector::empty<0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::query_types::AssetBorrow>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v6)) {
            let v8 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v6, v1);
            let v9 = 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::obligation::debt<T0>(v0, v8);
            0x1::vector::push_back<0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::query_types::AssetBorrow>(&mut v7, 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::query_types::new_asset_borrow(v8, 0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::floor(0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::debt::debt(v9, 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::borrow_index::value(0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::reserve::borrow_index<T0>(0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::reserve_by_type<T0>(arg0, v8))))), 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::user_oracle::get_price(arg3, v8, v4, arg4), 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::coin_decimals_registry::decimals(arg2, v8), *0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::debt::borrow_index(v9)));
            v1 = v1 + 1;
        };
        ObligationData{
            emode_group_id : 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::obligation::emode_group<T0>(v0),
            borrows        : v7,
            deposits       : v3,
        }
    }

    // decompiled from Move bytecode v6
}

