module 0x4a25c9153d59dd70d1ec7b27aca3bac94606233154c6dd27fb78261d71ad6080::box {
    struct Box<T0: store> has store, key {
        id: 0x2::object::UID,
        obj: T0,
    }

    public entry fun box<T0: store>(arg0: address, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Box<T0>{
            id  : 0x2::object::new(arg2),
            obj : arg1,
        };
        0x2::transfer::public_transfer<Box<T0>>(v0, arg0);
    }

    public fun unbox<T0: store>(arg0: Box<T0>) : T0 {
        let Box {
            id  : v0,
            obj : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    // decompiled from Move bytecode v6
}

