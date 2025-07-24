module 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap {
    struct ProtocolCap has store, key {
        id: 0x2::object::UID,
    }

    struct VerifiedProtocolCap has drop {
        dummy_field: bool,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap) : ProtocolCap {
        ProtocolCap{id: 0x2::object::new(arg0)}
    }

    public fun create_verified(arg0: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap) : VerifiedProtocolCap {
        VerifiedProtocolCap{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

