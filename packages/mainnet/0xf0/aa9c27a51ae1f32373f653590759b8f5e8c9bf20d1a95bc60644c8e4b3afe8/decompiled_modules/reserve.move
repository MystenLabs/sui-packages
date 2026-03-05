module 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::reserve {
    struct Reserve<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public fun ctoken_ratio<T0>(arg0: &Reserve<T0>) : 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::decimal::Decimal {
        abort 0
    }

    // decompiled from Move bytecode v6
}

