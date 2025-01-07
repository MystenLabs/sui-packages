module 0x6fc73d00024ba476f2189164a581fea37bbcce0b6311e9e023b0e4926c1a32a6::freezer {
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

