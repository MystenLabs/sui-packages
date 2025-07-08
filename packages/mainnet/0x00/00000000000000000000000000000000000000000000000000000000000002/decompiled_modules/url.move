module 0x2::url {
    struct Url has copy, drop, store {
        url: 0x1::ascii::String,
    }

    public fun inner_url(arg0: &Url) : 0x1::ascii::String {
        arg0.url
    }

    public fun new_unsafe(arg0: 0x1::ascii::String) : Url {
        Url{url: arg0}
    }

    public fun new_unsafe_from_bytes(arg0: vector<u8>) : Url {
        Url{url: 0x1::ascii::string(arg0)}
    }

    public fun update(arg0: &mut Url, arg1: 0x1::ascii::String) {
        arg0.url = arg1;
    }

    // decompiled from Move bytecode v6
}

