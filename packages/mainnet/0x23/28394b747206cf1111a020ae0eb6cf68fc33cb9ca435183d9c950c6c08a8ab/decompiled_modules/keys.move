module 0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::keys {
    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun type_to_balance_key<T0>() : BalanceKey<T0> {
        BalanceKey<T0>{dummy_field: false}
    }

    public fun type_to_string<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    // decompiled from Move bytecode v6
}

