module 0xd59200b49b4ad219ad4acc1ccaa77e7f9ec199f1167d9b96cf7ea848d172ae1b::freezer {
    struct Ice<T0: store + key> has key {
        id: 0x2::object::UID,
        obj: T0,
    }

    public entry fun freeze_object<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Ice<T0>{
            id  : 0x2::object::new(arg1),
            obj : arg0,
        };
        0x2::transfer::freeze_object<Ice<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

