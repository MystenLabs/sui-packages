module 0xa4de8f5e4f47721a3fffc34ab91f67db10158e1fc504dc4cef543b75efdc4fe7::hello {
    struct Hello has key {
        id: 0x2::object::UID,
        say: 0x1::ascii::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Hello{
            id  : 0x2::object::new(arg0),
            say : 0x1::ascii::string(b"Ch1hiro study move"),
        };
        0x2::transfer::transfer<Hello>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

