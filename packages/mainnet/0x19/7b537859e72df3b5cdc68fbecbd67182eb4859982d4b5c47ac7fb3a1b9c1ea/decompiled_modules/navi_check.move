module 0x197b537859e72df3b5cdc68fbecbd67182eb4859982d4b5c47ac7fb3a1b9c1ea::navi_check {
    struct Info has store, key {
        id: 0x2::object::UID,
        debt_raw: 0x2::vec_map::VecMap<0x1::ascii::String, u256>,
        debt_u64: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        collateral_raw: 0x2::vec_map::VecMap<0x1::ascii::String, u256>,
        collateral_u64: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        rewards_raw: 0x2::vec_map::VecMap<0x1::ascii::String, u256>,
        rewards_u64: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    public fun borrow<T0: drop>(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::borrow_with_account_cap<T0>(arg7, arg5, arg0, arg1, arg6, arg2, arg3, arg4, arg8), arg9), 0x2::tx_context::sender(arg9));
    }

    public fun deposit<T0: drop>(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: u8, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg0, arg1, arg2, arg5, arg3, arg4, arg7);
    }

    public fun generate_info(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, _, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg2, arg0, arg1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(arg3)));
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x2::vec_map::empty<0x1::ascii::String, u256>();
        let v8 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x1::ascii::String>(&v6)) {
            let v10 = *0x1::vector::borrow<0x1::ascii::String>(&v6, v9);
            let v11 = *0x1::vector::borrow<u256>(&v5, v9);
            if (0x2::vec_map::contains<0x1::ascii::String, u256>(&v7, &v10)) {
                let (_, v13) = 0x2::vec_map::remove<0x1::ascii::String, u256>(&mut v7, &v10);
                let (_, v15) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut v8, &v10);
                0x2::vec_map::insert<0x1::ascii::String, u256>(&mut v7, v10, v11 + v13);
                0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v8, v10, (v11 as u64) + v15);
            } else {
                0x2::vec_map::insert<0x1::ascii::String, u256>(&mut v7, v10, v11);
                0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v8, v10, (v11 as u64));
            };
            v9 = v9 + 1;
        };
        let (v16, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(arg3));
        let v18 = v16;
        let v19 = 0x2::vec_map::empty<0x1::ascii::String, u256>();
        let v20 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
        while (0x1::vector::length<u8>(&v18) > 0) {
            let v21 = 0x1::vector::pop_back<u8>(&mut v18);
            let v22 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg0, v21);
            let v23 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg0, v21, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(arg3));
            if (0x2::vec_map::contains<0x1::ascii::String, u256>(&v19, &v22)) {
                let (_, v25) = 0x2::vec_map::remove<0x1::ascii::String, u256>(&mut v19, &v22);
                let (_, v27) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut v20, &v22);
                0x2::vec_map::insert<0x1::ascii::String, u256>(&mut v19, v22, v23 + v25);
                0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v20, v22, (v23 as u64) + v27);
                continue
            };
            0x2::vec_map::insert<0x1::ascii::String, u256>(&mut v19, v22, v23);
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v20, v22, (v23 as u64));
        };
        let (_, v29) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(arg3));
        let v30 = v29;
        let v31 = 0x2::vec_map::empty<0x1::ascii::String, u256>();
        let v32 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
        while (0x1::vector::length<u8>(&v30) > 0) {
            let v33 = 0x1::vector::pop_back<u8>(&mut v30);
            let v34 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg0, v33);
            let v35 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg0, v33, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(arg3));
            if (0x2::vec_map::contains<0x1::ascii::String, u256>(&v31, &v34)) {
                let (_, v37) = 0x2::vec_map::remove<0x1::ascii::String, u256>(&mut v31, &v34);
                let (_, v39) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut v32, &v34);
                0x2::vec_map::insert<0x1::ascii::String, u256>(&mut v31, v34, v35 + v37);
                0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v32, v34, (v35 as u64) + v39);
                continue
            };
            0x2::vec_map::insert<0x1::ascii::String, u256>(&mut v31, v34, v35);
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v32, v34, (v35 as u64));
        };
        let v40 = Info{
            id             : 0x2::object::new(arg4),
            debt_raw       : v31,
            debt_u64       : v32,
            collateral_raw : v19,
            collateral_u64 : v20,
            rewards_raw    : v7,
            rewards_u64    : v8,
        };
        0x2::transfer::public_transfer<Info>(v40, 0x2::tx_context::sender(arg4));
    }

    public fun new_account(arg0: &mut 0x2::tx_context::TxContext) : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0)
    }

    public fun withdraw<T0: drop>(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: u64, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg9: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg10: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: address, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg13: &mut 0x2::tx_context::TxContext) {
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg7, arg8, arg4, arg9, arg10, arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg7, arg4, arg0, arg1, arg6, arg5, arg2, arg3, arg12), arg13), 0x2::tx_context::sender(arg13));
    }

    // decompiled from Move bytecode v6
}

