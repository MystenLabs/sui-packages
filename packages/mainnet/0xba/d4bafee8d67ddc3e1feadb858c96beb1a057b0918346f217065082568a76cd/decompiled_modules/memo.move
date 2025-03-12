module 0xbad4bafee8d67ddc3e1feadb858c96beb1a057b0918346f217065082568a76cd::memo {
    struct MemoEvent has copy, drop {
        message: 0x1::string::String,
    }

    public fun create_memo(arg0: vector<u8>) {
        let v0 = MemoEvent{message: 0x1::string::utf8(arg0)};
        0x2::event::emit<MemoEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

