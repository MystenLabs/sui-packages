module 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::utils {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) {
        if (arg1 < 0x2::clock::timestamp_ms(arg0)) {
            abort 0
        };
    }

    public fun check_order<T0, T1>() {
        if (!is_ordered<T0, T1>()) {
            abort 2
        };
    }

    public fun is_ordered<T0, T1>() : bool {
        let v0 = 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::comparator::compare_u8_vector(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        assert!(!0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::comparator::is_equal(&v0), 1);
        0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::comparator::is_smaller_than(&v0)
    }

    public fun refund<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun to_seconds(arg0: u64) : u64 {
        arg0 / 1000
    }

    // decompiled from Move bytecode v6
}

