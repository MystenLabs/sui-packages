module 0x354dcd45a1fd43c0767977be4e1cfe6a0508c82dade3f4ad63f5bf62bd231d18::dd {
    struct Object has key {
        id: 0x2::object::UID,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Object {
        Object{id: 0x2::object::new(arg0)}
    }

    entry fun create_and_transfer(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Object>(create(arg1), arg0);
    }

    // decompiled from Move bytecode v6
}

