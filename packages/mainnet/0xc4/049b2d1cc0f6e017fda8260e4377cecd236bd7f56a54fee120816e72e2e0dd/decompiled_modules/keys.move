module 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys {
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

