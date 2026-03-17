module 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation_query {
    struct ObligationData has copy, drop {
        emode_group_id: u8,
        borrows: vector<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::query_types::AssetBorrow>,
        deposits: vector<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::query_types::AssetDeposit>,
    }

    struct ObligationBorrow has copy, drop {
        asset: 0x1::type_name::TypeName,
        borrow_index: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        debt: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
    }

    struct ObligationDeposit has copy, drop {
        asset: 0x1::type_name::TypeName,
        ctoken_amount: u64,
    }

    struct ObligationDetail has copy, drop {
        emode_group_id: u8,
        borrows: vector<ObligationBorrow>,
        deposits: vector<ObligationDeposit>,
    }

    public fun get_obligation_assets<T0>(arg0: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg1: 0x2::object::ID) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        let v0 = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::borrow_obligation<T0>(arg0, arg1);
        (0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::debt_types<T0>(v0), 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::deposit_types<T0>(v0))
    }

    public fun get_obligation_detail<T0>(arg0: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg1: 0x2::object::ID, arg2: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::x_oracle::XOracle, arg4: &0x2::clock::Clock) : ObligationData {
        let v0 = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::deposit_types<T0>(v0);
        let v3 = 0x1::vector::empty<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::query_types::AssetDeposit>();
        let v4 = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::emode::get_oracle_base_token(0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::emode::borrow_emode_group(0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::emode_registry<T0>(arg0), 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::emode_group<T0>(v0)));
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v1);
            0x1::vector::push_back<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::query_types::AssetDeposit>(&mut v3, 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::query_types::new_asset_collateral_from_ctoken(v5, 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::ctoken_amount_by_coin<T0>(v0, v5), 0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::user_oracle::get_price(arg3, v5, v4, arg4), 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::coin_decimals_registry::decimals(arg2, v5), 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::reserve::exchange_rate<T0>(0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::reserve_by_type<T0>(arg0, v5))));
            v1 = v1 + 1;
        };
        v1 = 0;
        let v6 = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::debt_types<T0>(v0);
        let v7 = 0x1::vector::empty<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::query_types::AssetBorrow>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v6)) {
            let v8 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v6, v1);
            let v9 = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::debt<T0>(v0, v8);
            0x1::vector::push_back<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::query_types::AssetBorrow>(&mut v7, 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::query_types::new_asset_borrow(v8, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::floor(0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::debt::debt(v9, 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::borrow_index::value(0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::reserve::borrow_index<T0>(0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::reserve_by_type<T0>(arg0, v8))))), 0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::user_oracle::get_price(arg3, v8, v4, arg4), 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::coin_decimals_registry::decimals(arg2, v8), *0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::debt::borrow_index(v9)));
            v1 = v1 + 1;
        };
        ObligationData{
            emode_group_id : 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::emode_group<T0>(v0),
            borrows        : v7,
            deposits       : v3,
        }
    }

    public fun get_obligation_overview<T0>(arg0: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg1: 0x2::object::ID) : ObligationDetail {
        let v0 = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::deposit_types<T0>(v0);
        let v2 = 0x1::vector::empty<ObligationDeposit>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v3);
            let v5 = ObligationDeposit{
                asset         : v4,
                ctoken_amount : 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::ctoken_amount_by_coin<T0>(v0, v4),
            };
            0x1::vector::push_back<ObligationDeposit>(&mut v2, v5);
            v3 = v3 + 1;
        };
        let v6 = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::debt_types<T0>(v0);
        let v7 = 0x1::vector::empty<ObligationBorrow>();
        v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v6)) {
            let v8 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v6, v3);
            let v9 = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::debt<T0>(v0, v8);
            let v10 = ObligationBorrow{
                asset        : v8,
                borrow_index : *0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::debt::borrow_index(v9),
                debt         : 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::debt::unsafe_debt_amount(v9),
            };
            0x1::vector::push_back<ObligationBorrow>(&mut v7, v10);
            v3 = v3 + 1;
        };
        ObligationDetail{
            emode_group_id : 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::emode_group<T0>(v0),
            borrows        : v7,
            deposits       : v2,
        }
    }

    // decompiled from Move bytecode v6
}

