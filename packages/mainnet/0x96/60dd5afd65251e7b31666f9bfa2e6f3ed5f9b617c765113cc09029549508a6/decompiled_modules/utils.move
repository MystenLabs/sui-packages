module 0x9660dd5afd65251e7b31666f9bfa2e6f3ed5f9b617c765113cc09029549508a6::utils {
    public fun get_token_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun split_and_keep_coin<T0>(arg0: u64, arg1: vector<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg2);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        assert!(arg0 <= 0x2::coin::value<T0>(&v0), 2);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::pay::keep<T0>(v0, arg2);
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        0x2::coin::split<T0>(&mut v0, arg0, arg2)
    }

    // decompiled from Move bytecode v6
}

