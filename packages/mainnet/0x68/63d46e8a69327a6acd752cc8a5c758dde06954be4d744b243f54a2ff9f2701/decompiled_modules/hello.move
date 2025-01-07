module 0x6863d46e8a69327a6acd752cc8a5c758dde06954be4d744b243f54a2ff9f2701::hello {
    struct Hello has key {
        id: 0x2::object::UID,
        str: 0x1::string::String,
    }

    public fun say_hello(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Hello{
            id  : 0x2::object::new(arg0),
            str : 0x1::string::utf8(b"11532d"),
        };
        0x2::transfer::transfer<Hello>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

