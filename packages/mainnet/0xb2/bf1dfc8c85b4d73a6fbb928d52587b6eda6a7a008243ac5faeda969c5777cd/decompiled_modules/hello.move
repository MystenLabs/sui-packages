module 0xb2bf1dfc8c85b4d73a6fbb928d52587b6eda6a7a008243ac5faeda969c5777cd::hello {
    struct Hello has store, key {
        id: 0x2::object::UID,
        text: vector<u8>,
    }

    public entry fun create_hello(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Hello{
            id   : 0x2::object::new(arg0),
            text : b"Hello, Blockchain!",
        };
        0x2::transfer::transfer<Hello>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

