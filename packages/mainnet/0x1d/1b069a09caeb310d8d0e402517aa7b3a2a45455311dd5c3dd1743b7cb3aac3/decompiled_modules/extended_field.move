module 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::extended_field {
    struct ExtendedField<phantom T0: store> has store, key {
        id: 0x2::object::UID,
    }

    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    public fun borrow<T0: store>(arg0: &ExtendedField<T0>) : &T0 {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::borrow<Key, T0>(&arg0.id, v0)
    }

    public fun borrow_mut<T0: store>(arg0: &mut ExtendedField<T0>) : &mut T0 {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::borrow_mut<Key, T0>(&mut arg0.id, v0)
    }

    public fun swap<T0: store>(arg0: &mut ExtendedField<T0>, arg1: T0) : T0 {
        let v0 = Key{dummy_field: false};
        let v1 = Key{dummy_field: false};
        0x2::dynamic_field::add<Key, T0>(&mut arg0.id, v1, arg1);
        0x2::dynamic_field::remove<Key, T0>(&mut arg0.id, v0)
    }

    public fun new<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : ExtendedField<T0> {
        let v0 = 0x2::object::new(arg1);
        let v1 = Key{dummy_field: false};
        0x2::dynamic_field::add<Key, T0>(&mut v0, v1, arg0);
        ExtendedField<T0>{id: v0}
    }

    public fun destroy<T0: store>(arg0: ExtendedField<T0>) : T0 {
        let ExtendedField { id: v0 } = arg0;
        let v1 = Key{dummy_field: false};
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<Key, T0>(&mut v0, v1)
    }

    // decompiled from Move bytecode v6
}

