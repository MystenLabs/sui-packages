module 0xa512d79a6260d9a10c422530543bc8d5c113f88e255fcc0cb3dec0f7149c4787::e {
    struct P has copy, drop, store {
        i: 0x1::string::String,
    }

    public fun ipie(arg0: 0x1::string::String) {
        let v0 = P{i: arg0};
        0x2::event::emit<P>(v0);
    }

    // decompiled from Move bytecode v6
}

