module 0x90cd7f288fdf69d4e15c1901da67c64fe19e4e83c9493f46cbf5855b7afb96a9::coin_helper {
    public fun compare<T0, T1>() : 0x90cd7f288fdf69d4e15c1901da67c64fe19e4e83c9493f46cbf5855b7afb96a9::comparator::Result {
        0x90cd7f288fdf69d4e15c1901da67c64fe19e4e83c9493f46cbf5855b7afb96a9::comparator::compare_u8_vector(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())))
    }

    public fun is_sorted<T0, T1>() : bool {
        let v0 = compare<T0, T1>();
        assert!(!0x90cd7f288fdf69d4e15c1901da67c64fe19e4e83c9493f46cbf5855b7afb96a9::comparator::is_equal(&v0), 3000);
        0x90cd7f288fdf69d4e15c1901da67c64fe19e4e83c9493f46cbf5855b7afb96a9::comparator::is_smaller_than(&v0)
    }

    // decompiled from Move bytecode v6
}

