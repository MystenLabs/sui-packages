module 0x862e6e0d065981fb21e41dc59870b27b4abdf46f2b0cc01cf050172aed5cdb43::hello_world {
    struct HelloWorldObject has store, key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HelloWorldObject{
            id   : 0x2::object::new(arg0),
            text : 0x1::string::utf8(b"Hello, World!!"),
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
            text : 0x1::string::utf8(b"Extracting Function arguments is super simple!!"),
        };
        0x2::transfer::public_transfer<HelloWorldObject>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint4(arg0: &mut 0x2::tx_context::TxContext, arg1: 0x1::string::String) {
        abort 0
    }

    public fun mint5(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = HelloWorldObject{
            id   : 0x2::object::new(arg1),
            text : arg0,
        };
        0x2::transfer::public_transfer<HelloWorldObject>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

