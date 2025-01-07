module 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper {
    public fun compare<T0, T1>() : 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::comparator::Result {
        0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::comparator::compare_u8_vector(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())))
    }

    public fun is_sorted<T0, T1>() : bool {
        let v0 = compare<T0, T1>();
        assert!(!0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::comparator::is_equal(&v0), 3000);
        0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::comparator::is_smaller_than(&v0)
    }

    // decompiled from Move bytecode v6
}

