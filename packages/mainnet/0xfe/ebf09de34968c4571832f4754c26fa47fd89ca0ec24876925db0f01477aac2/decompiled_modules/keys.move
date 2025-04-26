module 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys {
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

