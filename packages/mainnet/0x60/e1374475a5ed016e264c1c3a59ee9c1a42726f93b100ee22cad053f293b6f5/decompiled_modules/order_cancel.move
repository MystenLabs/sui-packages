module 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_cancel {
    struct Cancel has copy, drop {
        order_bytes: vector<u8>,
    }

    public fun encode(arg0: Cancel) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg0.order_bytes));
        0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_list(&v0, false)
    }

    public fun decode(arg0: &vector<u8>) : Cancel {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_list(arg0);
        Cancel{order_bytes: *0x1::vector::borrow<vector<u8>>(&v0, 0)}
    }

    public fun get_order_bytes(arg0: &Cancel) : vector<u8> {
        arg0.order_bytes
    }

    public fun new(arg0: vector<u8>) : Cancel {
        Cancel{order_bytes: arg0}
    }

    // decompiled from Move bytecode v6
}

