module 0x3026d5e4fced67927fce0e5293ba4bbc77a6e0fa8226863ffca1b9a609489b93::ol {
    struct Ol has store, key {
        id: 0x2::object::UID,
        children: vector<0x2::object::ID>,
    }

    public fun add_child(arg0: 0x3026d5e4fced67927fce0e5293ba4bbc77a6e0fa8226863ffca1b9a609489b93::li::Li, arg1: &mut Ol) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.children, 0x3026d5e4fced67927fce0e5293ba4bbc77a6e0fa8226863ffca1b9a609489b93::li::id(&arg0));
        0x2::transfer::public_transfer<0x3026d5e4fced67927fce0e5293ba4bbc77a6e0fa8226863ffca1b9a609489b93::li::Li>(arg0, 0x2::object::uid_to_address(&arg1.id));
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Ol {
        Ol{
            id       : 0x2::object::new(arg0),
            children : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    // decompiled from Move bytecode v6
}

