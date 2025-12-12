module 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::obligation_query {
    struct ObligationData has copy, drop {
        emode_group_id: u8,
        borrows: vector<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::query_types::AssetBorrow>,
        deposits: vector<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::query_types::AssetDeposit>,
    }

    public fun get_obligation_assets<T0>(arg0: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg1: 0x2::object::ID) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        let v0 = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::borrow_obligation<T0>(arg0, arg1);
        (0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::obligation::debt_types<T0>(v0), 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::obligation::deposit_types<T0>(v0))
    }

    public fun get_obligation_detail<T0>(arg0: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg1: 0x2::object::ID, arg2: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg4: &0x2::clock::Clock) : ObligationData {
        let v0 = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::obligation::deposit_types<T0>(v0);
        let v3 = 0x1::vector::empty<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::query_types::AssetDeposit>();
        let v4 = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::emode::get_oracle_base_token(0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::emode::borrow_emode_group(0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::emode_registry<T0>(arg0), 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::obligation::emode_group<T0>(v0)));
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v1);
            0x1::vector::push_back<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::query_types::AssetDeposit>(&mut v3, 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::query_types::new_asset_collateral_from_ctoken(v5, 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::obligation::ctoken_amount_by_coin<T0>(v0, v5), 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::user_oracle::get_price(arg3, v5, v4, arg4), 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::decimals(arg2, v5), 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::reserve::exchange_rate<T0>(0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::reserve_by_type<T0>(arg0, v5))));
            v1 = v1 + 1;
        };
        v1 = 0;
        let v6 = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::obligation::debt_types<T0>(v0);
        let v7 = 0x1::vector::empty<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::query_types::AssetBorrow>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v6)) {
            let v8 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v6, v1);
            let v9 = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::obligation::debt<T0>(v0, v8);
            0x1::vector::push_back<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::query_types::AssetBorrow>(&mut v7, 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::query_types::new_asset_borrow(v8, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::floor(0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::debt::debt(v9, 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::borrow_index::value(0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::reserve::borrow_index<T0>(0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::reserve_by_type<T0>(arg0, v8))))), 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::user_oracle::get_price(arg3, v8, v4, arg4), 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::decimals(arg2, v8), *0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::debt::borrow_index(v9)));
            v1 = v1 + 1;
        };
        ObligationData{
            emode_group_id : 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::obligation::emode_group<T0>(v0),
            borrows        : v7,
            deposits       : v3,
        }
    }

    // decompiled from Move bytecode v6
}

