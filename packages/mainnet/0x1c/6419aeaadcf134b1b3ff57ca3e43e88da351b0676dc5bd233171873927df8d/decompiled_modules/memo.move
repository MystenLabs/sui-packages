module 0x1c6419aeaadcf134b1b3ff57ca3e43e88da351b0676dc5bd233171873927df8d::memo {
    struct Memo has store, key {
        id: 0x2::object::UID,
        from: address,
        text: 0x1::string::String,
    }

    public fun send(arg0: vector<u8>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Memo{
            id   : 0x2::object::new(arg2),
            from : 0x2::tx_context::sender(arg2),
            text : 0x1::string::utf8(arg0),
        };
        0x2::transfer::public_transfer<Memo>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

