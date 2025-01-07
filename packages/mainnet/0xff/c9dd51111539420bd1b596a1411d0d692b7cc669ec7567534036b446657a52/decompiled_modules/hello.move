module 0xffc9dd51111539420bd1b596a1411d0d692b7cc669ec7567534036b446657a52::hello {
    struct Hello has key {
        id: 0x2::object::UID,
        say: 0x1::ascii::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Hello{
            id  : 0x2::object::new(arg0),
            say : 0x1::ascii::string(b"SyugamCan"),
        };
        0x2::transfer::transfer<Hello>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

