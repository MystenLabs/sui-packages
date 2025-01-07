module 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::swap_utils {
    public fun get_amount_in(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > 0, 0);
        assert!(arg1 > 0 && arg2 > 0, 1);
        (((arg1 as u256) * (arg0 as u256) * (10000 as u256) / ((arg2 as u256) - (arg0 as u256)) * ((10000 as u256) - (arg3 as u256))) as u64) + 1
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > 0, 0);
        assert!(arg1 > 0 && arg2 > 0, 1);
        let v0 = (arg0 as u256) * ((10000 as u256) - (arg3 as u256));
        ((v0 * (arg2 as u256) / ((arg1 as u256) * (10000 as u256) + v0)) as u64)
    }

    public fun is_ordered<T0, T1>() : bool {
        let v0 = 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::comparator::compare_u8_vector(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        assert!(!0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::comparator::is_equal(&v0), 2);
        0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::comparator::is_smaller_than(&v0)
    }

    public fun left_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) : u64 {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 0);
        0x2::coin::value<T0>(arg0) - arg1
    }

    public fun quote(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 0);
        assert!(arg1 > 0 && arg2 > 0, 1);
        (((arg0 as u128) * (arg2 as u128) / (arg1 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

