module 0x4a25c9153d59dd70d1ec7b27aca3bac94606233154c6dd27fb78261d71ad6080::escrow {
    struct Escrow<T0: store + key> has key {
        id: 0x2::object::UID,
        recipient: address,
        obj: T0,
    }

    public entry fun transfer<T0: store + key>(arg0: Escrow<T0>) {
        let Escrow {
            id        : v0,
            recipient : v1,
            obj       : v2,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<T0>(v2, v1);
    }

    public entry fun escrow<T0: store + key>(arg0: address, arg1: address, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Escrow<T0>{
            id        : 0x2::object::new(arg3),
            recipient : arg1,
            obj       : arg2,
        };
        0x2::transfer::transfer<Escrow<T0>>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

