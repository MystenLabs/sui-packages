module 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation_query {
    struct ObligationData has copy, drop {
        emode_group_id: u8,
        borrows: vector<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::query_types::AssetBorrow>,
        deposits: vector<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::query_types::AssetDeposit>,
    }

    public fun get_obligation_assets<T0>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg1: 0x2::object::ID) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        let v0 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::borrow_obligation<T0>(arg0, arg1);
        (0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::debt_types<T0>(v0), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::deposit_types<T0>(v0))
    }

    public fun get_obligation_detail<T0>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg1: 0x2::object::ID, arg2: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg4: &0x2::clock::Clock) : ObligationData {
        let v0 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::deposit_types<T0>(v0);
        let v3 = 0x1::vector::empty<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::query_types::AssetDeposit>();
        let v4 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::get_oracle_base_token(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode_group(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::emode_registry<T0>(arg0), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::emode_group<T0>(v0)));
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v1);
            0x1::vector::push_back<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::query_types::AssetDeposit>(&mut v3, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::query_types::new_asset_collateral_from_ctoken(v5, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::ctoken_amount_by_coin<T0>(v0, v5), 0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::user_oracle::get_price(arg3, v5, v4, arg4), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::decimals(arg2, v5), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::exchange_rate<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::reserve_by_type<T0>(arg0, v5))));
            v1 = v1 + 1;
        };
        v1 = 0;
        let v6 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::debt_types<T0>(v0);
        let v7 = 0x1::vector::empty<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::query_types::AssetBorrow>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v6)) {
            let v8 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v6, v1);
            let v9 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::debt<T0>(v0, v8);
            0x1::vector::push_back<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::query_types::AssetBorrow>(&mut v7, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::query_types::new_asset_borrow(v8, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::floor(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::debt::debt(v9, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::borrow_index::value(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::borrow_index<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::reserve_by_type<T0>(arg0, v8))))), 0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::user_oracle::get_price(arg3, v8, v4, arg4), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::decimals(arg2, v8), *0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::debt::borrow_index(v9)));
            v1 = v1 + 1;
        };
        ObligationData{
            emode_group_id : 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::emode_group<T0>(v0),
            borrows        : v7,
            deposits       : v3,
        }
    }

    // decompiled from Move bytecode v6
}

