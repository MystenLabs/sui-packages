module 0x9f55cb1ee0f04dcdaa5bf75691a466bf72ce4d45a374afddcc81fa843472759::obligation_query {
    struct ObligationData has copy, drop {
        borrows: vector<0x9f55cb1ee0f04dcdaa5bf75691a466bf72ce4d45a374afddcc81fa843472759::types::AssetBorrow>,
        deposits: vector<0x9f55cb1ee0f04dcdaa5bf75691a466bf72ce4d45a374afddcc81fa843472759::types::AssetDeposit>,
    }

    public fun get_obligation_assets<T0>(arg0: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::Market<T0>, arg1: 0x2::object::ID) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        let v0 = 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::borrow_obligation<T0>(arg0, arg1);
        (0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::obligation::debt_types<T0>(v0), 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::obligation::deposit_types<T0>(v0))
    }

    public fun get_obligation_detail<T0>(arg0: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::Market<T0>, arg1: 0x2::object::ID, arg2: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg4: &0x2::clock::Clock) : ObligationData {
        let v0 = 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::obligation::deposit_types<T0>(v0);
        let v3 = 0x1::vector::empty<0x9f55cb1ee0f04dcdaa5bf75691a466bf72ce4d45a374afddcc81fa843472759::types::AssetDeposit>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v1);
            0x1::vector::push_back<0x9f55cb1ee0f04dcdaa5bf75691a466bf72ce4d45a374afddcc81fa843472759::types::AssetDeposit>(&mut v3, 0x9f55cb1ee0f04dcdaa5bf75691a466bf72ce4d45a374afddcc81fa843472759::types::new_asset_collateral_from_ctoken(v4, 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::obligation::ctoken_amount_by_coin<T0>(v0, v4), 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::value::get_price(arg3, v4, arg4), 0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::decimals(arg2, v4), 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::reserve::exchange_rate<T0>(0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::reserve_by_type<T0>(arg0, v4))));
            v1 = v1 + 1;
        };
        v1 = 0;
        let v5 = 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::obligation::debt_types<T0>(v0);
        let v6 = 0x1::vector::empty<0x9f55cb1ee0f04dcdaa5bf75691a466bf72ce4d45a374afddcc81fa843472759::types::AssetBorrow>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
            let v7 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v5, v1);
            let v8 = 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::obligation::debt<T0>(v0, v7);
            0x1::vector::push_back<0x9f55cb1ee0f04dcdaa5bf75691a466bf72ce4d45a374afddcc81fa843472759::types::AssetBorrow>(&mut v6, 0x9f55cb1ee0f04dcdaa5bf75691a466bf72ce4d45a374afddcc81fa843472759::types::new_asset_borrow(v7, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::floor(0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::debt::debt(v8, 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::borrow_index::value(0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::reserve::borrow_index<T0>(0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::reserve_by_type<T0>(arg0, v7))))), 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::value::get_price(arg3, v7, arg4), 0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::decimals(arg2, v7), *0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::debt::borrow_index(v8)));
            v1 = v1 + 1;
        };
        ObligationData{
            borrows  : v6,
            deposits : v3,
        }
    }

    // decompiled from Move bytecode v6
}

