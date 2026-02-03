module 0x97952b1a6aa4168732e864d0b94a678dcebf288f899f1861e8921164e44e5713::memo {
    struct MemoEvent has copy, drop {
        content: 0x1::string::String,
    }

    public fun write(arg0: vector<u8>) {
        let v0 = MemoEvent{content: 0x1::string::utf8(arg0)};
        0x2::event::emit<MemoEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

