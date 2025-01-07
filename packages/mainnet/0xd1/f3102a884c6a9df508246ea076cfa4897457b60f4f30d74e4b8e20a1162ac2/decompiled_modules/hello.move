module 0xd1f3102a884c6a9df508246ea076cfa4897457b60f4f30d74e4b8e20a1162ac2::hello {
    struct HelloWorldObject has store, key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HelloWorldObject{
            id   : 0x2::object::new(arg0),
            text : 0x1::string::utf8(b"Hello World!"),
        };
        0x2::transfer::transfer<HelloWorldObject>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

