module 0x5b1af417fe97ce96aa3fe90918b7c2dc5560abf0654684a39fd95a559e7bf2be::freezer {
    struct Ice<T0: store + key> has key {
        id: 0x2::object::UID,
        obj: T0,
    }

    entry fun freeze_object<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Ice<T0>{
            id  : 0x2::object::new(arg1),
            obj : arg0,
        };
        0x2::transfer::freeze_object<Ice<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

