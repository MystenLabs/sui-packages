module 0x3026d5e4fced67927fce0e5293ba4bbc77a6e0fa8226863ffca1b9a609489b93::p {
    struct P has store, key {
        id: 0x2::object::UID,
        content: 0x1::string::String,
    }

    public fun create(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : P {
        P{
            id      : 0x2::object::new(arg1),
            content : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

