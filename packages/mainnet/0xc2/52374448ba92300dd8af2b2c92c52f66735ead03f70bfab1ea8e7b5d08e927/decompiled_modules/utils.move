module 0xc252374448ba92300dd8af2b2c92c52f66735ead03f70bfab1ea8e7b5d08e927::utils {
    public(friend) fun payment_split_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(arg0) == arg1, 0);
        0x2::coin::split<T0>(arg0, 0x2::coin::value<T0>(arg0) * arg2 / 100, arg3)
    }

    public(friend) fun type_to_string<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()))
    }

    public(friend) fun withdraw_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(arg0), arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

