module 0xfb0e4a5b3c08f3a80792dd75592f1961916269e6d14c41ad8b4dd218ad79e81c::send_message {
    struct ImportantMessageEvent has copy, drop, store {
        text: 0x1::string::String,
    }

    public fun important_message(arg0: vector<u8>) {
        let v0 = ImportantMessageEvent{text: 0x1::string::utf8(arg0)};
        0x2::event::emit<ImportantMessageEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

