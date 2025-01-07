module 0x8686b9667821db83a232193c61650d45f2495d23e6b97a9d33cb5286e81a7758::coin_helper {
    public fun compare<T0, T1>() : 0x8686b9667821db83a232193c61650d45f2495d23e6b97a9d33cb5286e81a7758::comparator::Result {
        0x8686b9667821db83a232193c61650d45f2495d23e6b97a9d33cb5286e81a7758::comparator::compare_u8_vector(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())))
    }

    public fun is_sorted<T0, T1>() : bool {
        let v0 = compare<T0, T1>();
        assert!(!0x8686b9667821db83a232193c61650d45f2495d23e6b97a9d33cb5286e81a7758::comparator::is_equal(&v0), 3000);
        0x8686b9667821db83a232193c61650d45f2495d23e6b97a9d33cb5286e81a7758::comparator::is_smaller_than(&v0)
    }

    // decompiled from Move bytecode v6
}

