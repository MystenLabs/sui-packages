module 0x77aec58f5f8b7270180c9dbf03ba503e06e33ec4f3bc6212f0be36818a630722::dd {
    struct Object has key {
        id: 0x2::object::UID,
    }

    public fun add() : u8 {
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

