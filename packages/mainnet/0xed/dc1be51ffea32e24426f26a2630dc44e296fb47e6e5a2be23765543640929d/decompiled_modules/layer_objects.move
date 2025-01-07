module 0xeddc1be51ffea32e24426f26a2630dc44e296fb47e6e5a2be23765543640929d::layer_objects {
    struct Parent has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct Child has key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
    }

    public entry fun new_child(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Child{
            id          : 0x2::object::new(arg1),
            description : 0x1::string::utf8(b"this is a description"),
        };
        0x2::transfer::transfer<Child>(v0, arg0);
    }

    public entry fun new_parent(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Parent{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"hanmi"),
        };
        0x2::transfer::transfer<Parent>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

