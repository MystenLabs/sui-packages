module 0x20d8abb0943081c206cd6a58c1cbc3fd529184d973aa1723f923a680c1970ffb::blockboltpay {
    struct GenId has store, key {
        id: 0x2::object::UID,
        merchant_id: u64,
        merchant_name: 0x1::string::String,
    }

    public entry fun transaction_identifier(arg0: u64, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GenId{
            id            : 0x2::object::new(arg2),
            merchant_id   : arg0,
            merchant_name : arg1,
        };
        0x2::transfer::transfer<GenId>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

