module 0x862e6e0d065981fb21e41dc59870b27b4abdf46f2b0cc01cf050172aed5cdb43::hello_world {
    struct HelloWorldObject has store, key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HelloWorldObject{
            id   : 0x2::object::new(arg0),
            text : 0x1::string::utf8(b"Hello, World!"),
        };
        0x2::transfer::public_transfer<HelloWorldObject>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint2(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HelloWorldObject{
            id   : 0x2::object::new(arg0),
            text : 0x1::string::utf8(b"Hello, MVR!!"),
        };
        0x2::transfer::public_transfer<HelloWorldObject>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint3(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HelloWorldObject{
            id   : 0x2::object::new(arg0),
            text : 0x1::string::utf8(b"Extracting Function arguments is easy!!"),
        };
        0x2::transfer::public_transfer<HelloWorldObject>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

