module 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys {
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

