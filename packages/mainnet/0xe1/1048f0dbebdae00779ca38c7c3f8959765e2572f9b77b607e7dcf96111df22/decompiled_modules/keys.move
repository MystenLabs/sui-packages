module 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys {
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

