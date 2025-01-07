module 0x7e2a018df6774a48dce36fed52456ec3a0fc7147a210382cb544e6abd4a57eac::hello {
    struct Hello has key {
        id: 0x2::object::UID,
        str: 0x1::string::String,
    }

    public fun Hello_Sui(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Hello{
            id  : 0x2::object::new(arg0),
            str : 0x1::string::utf8(b"Hello Wulabalabo"),
        };
        0x2::transfer::transfer<Hello>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

