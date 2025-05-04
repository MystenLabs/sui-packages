module 0x10eda8ed708a3936c0dba3678ae38d923e04867ff8b1c59a90748f2f92c5d85d::freeze {
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

