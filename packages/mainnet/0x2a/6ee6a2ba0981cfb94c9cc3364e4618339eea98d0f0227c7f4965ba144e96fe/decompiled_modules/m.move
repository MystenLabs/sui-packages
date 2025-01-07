module 0x2a6ee6a2ba0981cfb94c9cc3364e4618339eea98d0f0227c7f4965ba144e96fe::m {
    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    struct C has store, key {
        id: 0x2::object::UID,
        s: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,
        i1: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,
        i2: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,
    }

    public fun cc(arg0: &Admin, arg1: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg3: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = C{
            id : 0x2::object::new(arg4),
            s  : arg1,
            i1 : arg2,
            i2 : arg3,
        };
        0x2::transfer::public_transfer<C>(v0, 0x2::tx_context::sender(arg4));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Admin>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun l01<T0, T1>(arg0: &mut C, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: 0x2::coin::Coin<T0>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        let v2 = false;
        let v3 = false;
        let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(&arg0.s);
        while (v4 > 0) {
            let v5 = v4 - 1;
            let v6 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(&arg0.s, v5);
            if (0x1::type_name::into_string(0x1::type_name::get<T0>()) == v6) {
                v0 = v5;
                v2 = true;
            };
            if (0x1::type_name::into_string(0x1::type_name::get<T1>()) == v6) {
                v1 = v5;
                v3 = true;
            };
            v4 = v4 - 1;
        };
        assert!(v2 && v3, 0);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::entry_liquidation<T0, T1>(arg1, arg2, &mut arg0.s, v0, arg3, arg5, v1, arg4, arg6, 0x2::coin::value<T0>(&arg5), &mut arg0.i1, &mut arg0.i2, arg7);
    }

    // decompiled from Move bytecode v6
}

