module 0x437e25d005e57a4879e2af64bbb3009bff402492f497c850959138508c4c0eb5::utils {
    public fun create_msg(arg0: address, arg1: 0x2::object::ID) : vector<u8> {
        let v0 = 0x2::address::to_string(arg0);
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::object::id_to_address(&arg1)));
        0x1::string::into_bytes(v0)
    }

    public fun create_msg_string(arg0: address, arg1: 0x2::object::ID) : 0x1::string::String {
        let v0 = 0x2::address::to_string(arg0);
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::object::id_to_address(&arg1)));
        v0
    }

    public(friend) fun type_to_string<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()))
    }

    public(friend) fun withdraw_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(arg0), arg1), arg1);
    }

    public(friend) fun withdraw_balance_to_coin<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(arg0), arg1)
    }

    public(friend) fun withdraw_balance_value<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg1), arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

