module 0x9c9682947592b81f67d691f128d8082649980de3225ca773a570bce5cdfe4b95::send_message {
    struct ImportantMessageEvent has copy, drop, store {
        text: 0x1::string::String,
    }

    public fun send_message(arg0: vector<u8>) {
        let v0 = ImportantMessageEvent{text: 0x1::string::utf8(arg0)};
        0x2::event::emit<ImportantMessageEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

