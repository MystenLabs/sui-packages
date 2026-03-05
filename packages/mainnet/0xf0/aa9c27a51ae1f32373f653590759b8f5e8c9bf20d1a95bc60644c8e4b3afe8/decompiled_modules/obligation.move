module 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::obligation {
    struct Obligation<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public fun deposited_ctoken_amount<T0, T1>(arg0: &Obligation<T0>) : u64 {
        abort 0
    }

    // decompiled from Move bytecode v6
}

