module 0xef872d7d365d675ce1dd60baea6df88ca243386b8a989b110408da386de77576::dd {
    struct Object has key {
        id: 0x2::object::UID,
    }

    public entry fun add() : u8 {
        2
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Object {
        Object{id: 0x2::object::new(arg0)}
    }

    entry fun create_and_transfer(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Object>(create(arg1), arg0);
    }

    // decompiled from Move bytecode v6
}

