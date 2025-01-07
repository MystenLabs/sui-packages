module 0x5c5ddaaed85471c25b9632387c02f9aab60a595bde4fc419c8c670548ebf2cdb::hello {
    struct Hello has key {
        id: 0x2::object::UID,
        say: 0x1::ascii::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Hello{
            id  : 0x2::object::new(arg0),
            say : 0x1::ascii::string(b"move zebing123"),
        };
        0x2::transfer::transfer<Hello>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

