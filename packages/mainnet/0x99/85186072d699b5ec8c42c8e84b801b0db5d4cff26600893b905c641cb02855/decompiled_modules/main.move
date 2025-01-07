module 0x9985186072d699b5ec8c42c8e84b801b0db5d4cff26600893b905c641cb02855::main {
    struct Config has store, key {
        id: 0x2::object::UID,
        times: u8,
        assets: 0x2::table::Table<0x1::ascii::String, u8>,
    }

    public entry fun assets(arg0: &mut Config, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        let v0 = 0;
        while (v0 < 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg1)) {
            let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg1, v0);
            if (!0x2::table::contains<0x1::ascii::String, u8>(&arg0.assets, v1)) {
                0x2::table::add<0x1::ascii::String, u8>(&mut arg0.assets, v1, v0);
            };
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id     : 0x2::object::new(arg0),
            times  : 2,
            assets : 0x2::table::new<0x1::ascii::String, u8>(arg0),
        };
        0x2::transfer::public_transfer<Config>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun l01<T0, T1>(arg0: &Config, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: 0x2::coin::Coin<T0>, arg5: address, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(0x2::table::contains<0x1::ascii::String, u8>(&arg0.assets, v0), 6666);
        assert!(0x2::table::contains<0x1::ascii::String, u8>(&arg0.assets, v1), 7777);
        assert!(!0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::is_health(arg1, arg2, arg3, arg5), 8888);
        let v2 = *0x2::table::borrow<0x1::ascii::String, u8>(&arg0.assets, v0);
        let v3 = 0;
        let v4 = 0x2::coin::into_balance<T0>(arg4);
        let v5 = 0x2::balance::zero<T1>();
        while (v3 < arg0.times && !0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::is_health(arg1, arg2, arg3, arg5)) {
            let (v6, v7) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::liquidation<T0, T1>(arg1, arg2, arg3, v2, arg6, 0x2::balance::split<T0>(&mut v4, 0x2::math::min(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg6, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg3, v2, arg5) as u64)), 0x2::balance::value<T0>(&v4))), *0x2::table::borrow<0x1::ascii::String, u8>(&arg0.assets, v1), arg7, arg5, arg8, arg9, arg10);
            0x2::balance::join<T0>(&mut v4, v7);
            0x2::balance::join<T1>(&mut v5, v6);
            v3 = v3 + 1;
        };
        if (0x2::balance::value<T0>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T0>(v4);
        };
        if (0x2::balance::value<T1>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
    }

    public entry fun times(arg0: &mut Config, arg1: u8) {
        arg0.times = arg1;
    }

    // decompiled from Move bytecode v6
}

