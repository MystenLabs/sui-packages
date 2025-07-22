module 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::utils {
    public(friend) fun adjust_for_slippage(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u128 {
        assert!(arg2 > 0, 6);
        assert!(arg1 <= arg2, 5);
        if (arg3) {
            arg0 * (arg2 + arg1) / arg2
        } else {
            arg0 * arg2 / (arg2 + arg1)
        }
    }

    public(friend) fun calc_sqrt_price_max_limit(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 <= 10000, 5);
        arg0 * (10000 + arg1) / 10000
    }

    public fun destroy_zero_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun destroy_zero_or_transfer_to_receiver<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    public fun get_coin_info<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun handle_coin_vector<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg2);
        if (0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            return v0
        };
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        let v1 = 0x2::coin::value<T0>(&v0);
        if (v1 > arg1) {
            0x2::pay::split_and_transfer<T0>(&mut v0, v1 - arg1, 0x2::tx_context::sender(arg2), arg2);
        };
        v0
    }

    public(friend) fun has_duplicates(arg0: &vector<vector<u8>>) : bool {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                if (0x1::vector::borrow<vector<u8>>(arg0, v1) == 0x1::vector::borrow<vector<u8>>(arg0, v2)) {
                    return true
                };
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
        false
    }

    public(friend) fun verify_signature(arg0: &0x2::table::Table<vector<u8>, bool>, arg1: u64, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>) : bool {
        let v0 = 0x1::vector::length<vector<u8>>(&arg3);
        assert!(v0 >= arg1, 1);
        assert!(!has_duplicates(&arg3), 3);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x2::table::contains<vector<u8>, bool>(arg0, *0x1::vector::borrow<vector<u8>>(&arg3, v1)), 4);
            assert!(0x2::ed25519::ed25519_verify(0x1::vector::borrow<vector<u8>>(&arg4, v1), 0x1::vector::borrow<vector<u8>>(&arg3, v1), &arg2), 2);
            v1 = v1 + 1;
        };
        true
    }

    // decompiled from Move bytecode v6
}

