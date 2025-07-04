module 0xd2bdd80206e53b946455d8f915769c860c893ac223b8718a35b113bf5e9a45aa::utils {
    public(friend) fun payment_split_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(arg0) == arg1, 0);
        0x2::coin::split<T0>(arg0, (((0x2::coin::value<T0>(arg0) as u128) * (arg2 as u128) / 10000) as u64), arg3)
    }

    public(friend) fun type_to_string<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()))
    }

    public(friend) fun withdraw_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(arg0), arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

