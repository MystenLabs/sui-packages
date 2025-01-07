module 0xa5743a3413affa6d6e24f6a560d38b1924aacd46043a1cb833db97b2160c34de::l1 {
    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Admin>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun l01<T0, T1>(arg0: &Admin, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: 0x2::coin::Coin<T0>, arg5: address, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        let v3 = false;
        let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg3);
        while (v4 > 0) {
            let v5 = v4 - 1;
            let v6 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg3, v5);
            if (0x1::type_name::into_string(0x1::type_name::get<T0>()) == v6) {
                v0 = v5;
                v1 = true;
            };
            if (0x1::type_name::into_string(0x1::type_name::get<T1>()) == v6) {
                v2 = v5;
                v3 = true;
            };
            v4 = v4 - 1;
        };
        assert!(v1 && v3, 9999);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::liquidation_call<T0, T1>(arg1, arg2, arg3, v0, arg6, v2, arg7, arg4, arg5, 0x2::coin::value<T0>(&arg4), arg8, arg9);
    }

    public fun l02<T0, T1>(arg0: &Admin, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: 0x2::coin::Coin<T0>, arg5: address, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        let v3 = false;
        let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg3);
        while (v4 > 0) {
            let v5 = v4 - 1;
            let v6 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg3, v5);
            if (0x1::type_name::into_string(0x1::type_name::get<T0>()) == v6) {
                v0 = v5;
                v1 = true;
            };
            if (0x1::type_name::into_string(0x1::type_name::get<T1>()) == v6) {
                v2 = v5;
                v3 = true;
            };
            v4 = v4 - 1;
        };
        assert!(v1 && v3, 9999);
        let v7 = 0x2::coin::into_balance<T0>(arg4);
        assert!(!0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::is_health(arg1, arg2, arg3, arg5), 8888);
        let v8 = 0;
        while (!0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::is_health(arg1, arg2, arg3, arg5) && 0x2::balance::value<T0>(&v7) > 0 && v8 < 5) {
            let v9 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg3, v0, arg5);
            let v10 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg6, (v9 as u64));
            if (v9 < 100000000) {
                break
            };
            let v11 = v10;
            if (0x2::balance::value<T0>(&v7) < v10) {
                v11 = 0x2::balance::value<T0>(&v7);
            };
            let v12 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, v11), arg9);
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::liquidation_call<T0, T1>(arg1, arg2, arg3, v0, arg6, v2, arg7, v12, arg5, 0x2::coin::value<T0>(&v12), arg8, arg9);
            v8 = v8 + 1;
        };
        if (0x2::balance::value<T0>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg9), 0x2::tx_context::sender(arg9));
        } else {
            0x2::balance::destroy_zero<T0>(v7);
        };
    }

    public fun l03<T0, T1>(arg0: &Admin, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: 0x2::coin::Coin<T0>, arg5: address, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        let v3 = false;
        let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg3);
        while (v4 > 0) {
            let v5 = v4 - 1;
            let v6 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg3, v5);
            if (0x1::type_name::into_string(0x1::type_name::get<T0>()) == v6) {
                v0 = v5;
                v1 = true;
            };
            if (0x1::type_name::into_string(0x1::type_name::get<T1>()) == v6) {
                v2 = v5;
                v3 = true;
            };
            v4 = v4 - 1;
        };
        assert!(v1 && v3, 9999);
        assert!(!0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::is_health(arg1, arg2, arg3, arg5), 8888);
        let v7 = 0x2::coin::into_balance<T0>(arg4);
        let v8 = 0x2::balance::zero<T1>();
        let v9 = 0;
        while (!0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::is_health(arg1, arg2, arg3, arg5) && 0x2::balance::value<T0>(&v7) > 0 && v9 < 5) {
            let v10 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg3, v0, arg5);
            let v11 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg6, (v10 as u64));
            if (v10 < 100000000) {
                break
            };
            let v12 = v11;
            if (0x2::balance::value<T0>(&v7) < v11) {
                v12 = 0x2::balance::value<T0>(&v7);
            };
            let (v13, v14) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::liquidation<T0, T1>(arg1, arg2, arg3, v0, arg6, 0x2::balance::split<T0>(&mut v7, v12), v2, arg7, arg5, arg8, arg9, arg10);
            0x2::balance::join<T0>(&mut v7, v14);
            0x2::balance::join<T1>(&mut v8, v13);
            v9 = v9 + 1;
        };
        if (0x2::balance::value<T0>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T0>(v7);
        };
        if (0x2::balance::value<T1>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T1>(v8);
        };
    }

    fun rm(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= (0x2::address::max() - 500000000000000000000000000) / arg1, 7777);
        (arg0 * arg1 + 500000000000000000000000000) / 1000000000000000000000000000
    }

    // decompiled from Move bytecode v6
}

