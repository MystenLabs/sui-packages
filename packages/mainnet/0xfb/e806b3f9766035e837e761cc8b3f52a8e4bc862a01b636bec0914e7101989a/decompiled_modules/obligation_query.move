module 0xfbe806b3f9766035e837e761cc8b3f52a8e4bc862a01b636bec0914e7101989a::obligation_query {
    struct ObligationData has copy, drop {
        emode_group_id: u8,
        borrows: vector<0xfbe806b3f9766035e837e761cc8b3f52a8e4bc862a01b636bec0914e7101989a::types::AssetBorrow>,
        deposits: vector<0xfbe806b3f9766035e837e761cc8b3f52a8e4bc862a01b636bec0914e7101989a::types::AssetDeposit>,
    }

    public fun get_obligation_assets<T0>(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg1: 0x2::object::ID) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        let v0 = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::borrow_obligation<T0>(arg0, arg1);
        (0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::obligation::debt_types<T0>(v0), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::obligation::deposit_types<T0>(v0))
    }

    public fun get_obligation_detail<T0>(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg1: 0x2::object::ID, arg2: &0x4abb202e193c18f6d5b418ef03418fd5e77f40d57a19355fececf8079fa1db98::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x5060fa94bc49945536eae3d46583d1d85dd3b1c549e5b83b48b0dfe9833ff404::x_oracle::XOracle, arg4: &0x2::clock::Clock) : ObligationData {
        let v0 = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::obligation::deposit_types<T0>(v0);
        let v3 = 0x1::vector::empty<0xfbe806b3f9766035e837e761cc8b3f52a8e4bc862a01b636bec0914e7101989a::types::AssetDeposit>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v1);
            0x1::vector::push_back<0xfbe806b3f9766035e837e761cc8b3f52a8e4bc862a01b636bec0914e7101989a::types::AssetDeposit>(&mut v3, 0xfbe806b3f9766035e837e761cc8b3f52a8e4bc862a01b636bec0914e7101989a::types::new_asset_collateral_from_ctoken(v4, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::obligation::ctoken_amount_by_coin<T0>(v0, v4), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::value::get_price(arg3, v4, arg4), 0x4abb202e193c18f6d5b418ef03418fd5e77f40d57a19355fececf8079fa1db98::coin_decimals_registry::decimals(arg2, v4), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::exchange_rate<T0>(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::reserve_by_type<T0>(arg0, v4))));
            v1 = v1 + 1;
        };
        v1 = 0;
        let v5 = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::obligation::debt_types<T0>(v0);
        let v6 = 0x1::vector::empty<0xfbe806b3f9766035e837e761cc8b3f52a8e4bc862a01b636bec0914e7101989a::types::AssetBorrow>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
            let v7 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v5, v1);
            let v8 = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::obligation::debt<T0>(v0, v7);
            0x1::vector::push_back<0xfbe806b3f9766035e837e761cc8b3f52a8e4bc862a01b636bec0914e7101989a::types::AssetBorrow>(&mut v6, 0xfbe806b3f9766035e837e761cc8b3f52a8e4bc862a01b636bec0914e7101989a::types::new_asset_borrow(v7, 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::floor(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::debt::debt(v8, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::borrow_index::value(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::borrow_index<T0>(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::reserve_by_type<T0>(arg0, v7))))), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::value::get_price(arg3, v7, arg4), 0x4abb202e193c18f6d5b418ef03418fd5e77f40d57a19355fececf8079fa1db98::coin_decimals_registry::decimals(arg2, v7), *0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::debt::borrow_index(v8)));
            v1 = v1 + 1;
        };
        ObligationData{
            emode_group_id : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::obligation::emode_group<T0>(v0),
            borrows        : v6,
            deposits       : v3,
        }
    }

    // decompiled from Move bytecode v6
}

