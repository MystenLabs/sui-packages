module 0x5c3d4f658360c7a626c5818bd17bdd960e55c6f697c3336e8a917ea6ffbc0805::hello_world {
    struct HelloWorldObject has store, key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HelloWorldObject{
            id   : 0x2::object::new(arg0),
            text : 0x1::string::utf8(b"Hello World!"),
        };
        0x2::transfer::public_transfer<HelloWorldObject>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

