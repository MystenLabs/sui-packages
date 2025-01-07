module 0xfdf6fba7fe9980e89e905250018b94865ad4c5424a2ccc6bfe295abe262755b0::hello {
    struct Hello has key {
        id: 0x2::object::UID,
        str: 0x1::string::String,
    }

    public fun say_hello(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Hello{
            id  : 0x2::object::new(arg0),
            str : 0x1::string::utf8(b"Hello yueliao11"),
        };
        0x2::transfer::transfer<Hello>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

