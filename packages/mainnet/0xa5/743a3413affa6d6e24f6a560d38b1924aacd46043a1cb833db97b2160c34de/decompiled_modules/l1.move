module 0xa5743a3413affa6d6e24f6a560d38b1924aacd46043a1cb833db97b2160c34de::l1 {
    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Admin>(v0, 0x2::tx_context::sender(arg0));
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
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::liquidation_call<T0, T1>(arg1, arg2, arg3, v0, arg6, v2, arg7, arg4, arg5, 0x2::coin::value<T0>(&arg4), arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

