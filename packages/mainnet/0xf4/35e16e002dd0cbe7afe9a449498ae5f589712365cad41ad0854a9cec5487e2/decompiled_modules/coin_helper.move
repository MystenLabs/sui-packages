module 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::coin_helper {
    public fun compare<T0, T1>() : 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::comparator::Result {
        0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::comparator::compare_u8_vector(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())))
    }

    public fun is_sorted<T0, T1>() : bool {
        let v0 = compare<T0, T1>();
        assert!(!0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::comparator::is_equal(&v0), 3000);
        0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::comparator::is_smaller_than(&v0)
    }

    // decompiled from Move bytecode v6
}

