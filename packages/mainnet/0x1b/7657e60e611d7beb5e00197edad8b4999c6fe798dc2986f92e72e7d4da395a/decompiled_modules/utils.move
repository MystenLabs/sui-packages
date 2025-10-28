module 0x1b7657e60e611d7beb5e00197edad8b4999c6fe798dc2986f92e72e7d4da395a::utils {
    public fun add_balance_to_bag<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::balance::Balance<T0>) : u64 {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        if (0x2::bag::contains<0x1::string::String>(arg0, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0, arg1);
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0))
    }

    public fun remove_balance_from_bag<T0>(arg0: &mut 0x2::bag::Bag, arg1: u64, arg2: bool) : (0x2::balance::Balance<T0>, u64) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        if (!0x2::bag::contains<0x1::string::String>(arg0, v0)) {
            return (0x2::balance::zero<T0>(), 0)
        };
        let v1 = 0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0));
        if (arg2) {
            return (0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0), 0)
        };
        assert!(v1 >= arg1, 13906834517940764673);
        (0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0), arg1), v1 - arg1)
    }

    public fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

