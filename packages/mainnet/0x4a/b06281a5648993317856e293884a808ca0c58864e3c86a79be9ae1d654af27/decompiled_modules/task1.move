module 0x4ab06281a5648993317856e293884a808ca0c58864e3c86a79be9ae1d654af27::task1 {
    struct HelloWorld has store, key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HelloWorld{
            id   : 0x2::object::new(arg0),
            text : 0x1::string::utf8(b"Hello World to Lumia01!"),
        };
        0x2::transfer::transfer<HelloWorld>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

