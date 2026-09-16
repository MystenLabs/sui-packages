module 0xa684d12435a8ce17c68e1e91b97226e501d300eea2af83caf76f4ea88738d080::tto_demo {
    struct Box has store, key {
        id: 0x2::object::UID,
    }

    entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Box{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Box>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun take<T0: store + key>(arg0: &mut Box, arg1: 0x2::transfer::Receiving<T0>) : T0 {
        0x2::transfer::public_receive<T0>(&mut arg0.id, arg1)
    }

    entry fun take_to_sender<T0: store + key>(arg0: &mut Box, arg1: 0x2::transfer::Receiving<T0>, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(take<T0>(arg0, arg1), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

