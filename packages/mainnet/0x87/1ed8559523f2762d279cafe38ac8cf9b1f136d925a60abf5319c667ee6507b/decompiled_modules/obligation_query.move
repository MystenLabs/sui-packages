module 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation_query {
    struct ObligationData has copy, drop {
        emode_group_id: u8,
        borrows: vector<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::query_types::AssetBorrow>,
        deposits: vector<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::query_types::AssetDeposit>,
    }

    public fun get_obligation_assets<T0>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg1: 0x2::object::ID) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        let v0 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::borrow_obligation<T0>(arg0, arg1);
        (0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::debt_types<T0>(v0), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::deposit_types<T0>(v0))
    }

    public fun get_obligation_detail<T0>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg1: 0x2::object::ID, arg2: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg4: &0x2::clock::Clock) : ObligationData {
        let v0 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::deposit_types<T0>(v0);
        let v3 = 0x1::vector::empty<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::query_types::AssetDeposit>();
        let v4 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::get_oracle_base_token(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode_group(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::emode_registry<T0>(arg0), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::emode_group<T0>(v0)));
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v1);
            0x1::vector::push_back<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::query_types::AssetDeposit>(&mut v3, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::query_types::new_asset_collateral_from_ctoken(v5, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::ctoken_amount_by_coin<T0>(v0, v5), 0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::user_oracle::get_price(arg3, v5, v4, arg4), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::decimals(arg2, v5), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::exchange_rate<T0>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::reserve_by_type<T0>(arg0, v5))));
            v1 = v1 + 1;
        };
        v1 = 0;
        let v6 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::debt_types<T0>(v0);
        let v7 = 0x1::vector::empty<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::query_types::AssetBorrow>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v6)) {
            let v8 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v6, v1);
            let v9 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::debt<T0>(v0, v8);
            0x1::vector::push_back<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::query_types::AssetBorrow>(&mut v7, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::query_types::new_asset_borrow(v8, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::floor(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::debt::debt(v9, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::borrow_index::value(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::borrow_index<T0>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::reserve_by_type<T0>(arg0, v8))))), 0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::user_oracle::get_price(arg3, v8, v4, arg4), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::decimals(arg2, v8), *0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::debt::borrow_index(v9)));
            v1 = v1 + 1;
        };
        ObligationData{
            emode_group_id : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::emode_group<T0>(v0),
            borrows        : v7,
            deposits       : v3,
        }
    }

    // decompiled from Move bytecode v6
}

