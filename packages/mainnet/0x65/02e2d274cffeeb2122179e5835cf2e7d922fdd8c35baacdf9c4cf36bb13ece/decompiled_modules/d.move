module 0x6502e2d274cffeeb2122179e5835cf2e7d922fdd8c35baacdf9c4cf36bb13ece::d {
    struct NUC has copy, drop {
        asset: u8,
        coin_type: 0x1::ascii::String,
        user_collateral_value: u256,
        user_collateral_balance: u256,
    }

    struct NUL has copy, drop {
        asset: u8,
        coin_type: 0x1::ascii::String,
        user_loan_value: u256,
        user_loan_balance: u256,
    }

    struct NU has copy, drop {
        user: address,
        user_assets: vector<NUC>,
        user_loans: vector<NUL>,
        user_health_loan_value: u256,
        user_health_factor: u256,
        user_health_collateral_value: u256,
        dynamic_liquidation_threshold: u256,
    }

    struct NA has copy, drop {
        asset: u8,
        liquidation_factors_0: u256,
        liquidation_factors_1: u256,
        liquidation_factors_2: u256,
        index_0: u256,
        index_1: u256,
    }

    struct NS has copy, drop {
        assets: vector<NA>,
    }

    public fun ns(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0x2::tx_context::TxContext) : NS {
        let v0 = 0x1::vector::empty<NA>();
        let v1 = 0;
        while (v1 < 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg1)) {
            let (v2, v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg1, v1);
            let (v5, v6) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg1, v1);
            let v7 = NA{
                asset                 : v1,
                liquidation_factors_0 : v2,
                liquidation_factors_1 : v3,
                liquidation_factors_2 : v4,
                index_0               : v5,
                index_1               : v6,
            };
            0x1::vector::push_back<NA>(&mut v0, v7);
            v1 = v1 + 1;
        };
        let v8 = NS{assets: v0};
        0x2::event::emit<NS>(v8);
        v8
    }

    public fun nu(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : NU {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::empty<NUC>();
        let v5 = 0x1::vector::empty<NUL>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<u8>(&v3)) {
            let v7 = *0x1::vector::borrow<u8>(&v3, v6);
            let v8 = NUC{
                asset                   : v7,
                coin_type               : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg2, v7),
                user_collateral_value   : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg0, arg1, arg2, v7, arg3),
                user_collateral_balance : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, v7, arg3),
            };
            0x1::vector::push_back<NUC>(&mut v4, v8);
            v6 = v6 + 1;
        };
        v6 = 0;
        while (v6 < 0x1::vector::length<u8>(&v2)) {
            let v9 = *0x1::vector::borrow<u8>(&v2, v6);
            let v10 = NUL{
                asset             : v9,
                coin_type         : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg2, v9),
                user_loan_value   : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_value(arg0, arg1, arg2, v9, arg3),
                user_loan_balance : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg2, v9, arg3),
            };
            0x1::vector::push_back<NUL>(&mut v5, v10);
            v6 = v6 + 1;
        };
        let v11 = NU{
            user                          : arg3,
            user_assets                   : v4,
            user_loans                    : v5,
            user_health_loan_value        : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_loan_value(arg0, arg1, arg2, arg3),
            user_health_factor            : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor(arg0, arg2, arg1, arg3),
            user_health_collateral_value  : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_collateral_value(arg0, arg1, arg2, arg3),
            dynamic_liquidation_threshold : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::dynamic_liquidation_threshold(arg0, arg2, arg1, arg3),
        };
        0x2::event::emit<NU>(v11);
        v11
    }

    // decompiled from Move bytecode v6
}

