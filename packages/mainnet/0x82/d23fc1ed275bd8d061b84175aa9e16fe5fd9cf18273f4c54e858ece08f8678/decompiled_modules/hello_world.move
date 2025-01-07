module 0x82d23fc1ed275bd8d061b84175aa9e16fe5fd9cf18273f4c54e858ece08f8678::hello_world {
    struct HelloWorldObject has store, key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
    }

    public entry fun mint(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = HelloWorldObject{
            id   : 0x2::object::new(arg1),
            text : 0x1::string::utf8(arg0),
        };
        0x2::transfer::transfer<HelloWorldObject>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

