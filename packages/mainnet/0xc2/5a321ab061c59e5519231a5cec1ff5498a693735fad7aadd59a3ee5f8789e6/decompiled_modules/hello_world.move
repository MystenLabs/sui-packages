module 0xc25a321ab061c59e5519231a5cec1ff5498a693735fad7aadd59a3ee5f8789e6::hello_world {
    struct HelloWorldObject has store, key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HelloWorldObject{
            id   : 0x2::object::new(arg0),
            text : 0x1::string::utf8(b"Hello World!"),
        };
        0x2::transfer::public_transfer<HelloWorldObject>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

