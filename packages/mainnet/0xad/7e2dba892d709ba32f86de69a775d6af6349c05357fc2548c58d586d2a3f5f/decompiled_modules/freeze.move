module 0xad7e2dba892d709ba32f86de69a775d6af6349c05357fc2548c58d586d2a3f5f::freeze {
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

