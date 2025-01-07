module 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::immutable {
    struct Immutable<T0: store> has key {
        id: 0x2::object::UID,
        allow_read: bool,
        contents: T0,
    }

    public fun borrow<T0: store>(arg0: &Immutable<T0>) : &T0 {
        assert!(arg0.allow_read, 0);
        &arg0.contents
    }

    public fun freeze_<T0: store>(arg0: T0, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Immutable<T0>{
            id         : 0x2::object::new(arg2),
            allow_read : arg1,
            contents   : arg0,
        };
        0x2::transfer::freeze_object<Immutable<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

