module 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_fill {
    struct OrderFill has copy, drop, store {
        id: u128,
        order_bytes: vector<u8>,
        solver: 0x1::string::String,
    }

    public fun encode(arg0: &OrderFill) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_u128(arg0.id));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg0.order_bytes));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_string(&arg0.solver));
        0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_list(&v0, false)
    }

    public fun decode(arg0: &vector<u8>) : OrderFill {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_list(arg0);
        OrderFill{
            id          : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_u128(0x1::vector::borrow<vector<u8>>(&v0, 0)),
            order_bytes : *0x1::vector::borrow<vector<u8>>(&v0, 1),
            solver      : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_string(0x1::vector::borrow<vector<u8>>(&v0, 2)),
        }
    }

    public fun get_id(arg0: &OrderFill) : u128 {
        arg0.id
    }

    public fun get_order_bytes(arg0: &OrderFill) : vector<u8> {
        arg0.order_bytes
    }

    public fun get_solver(arg0: &OrderFill) : 0x1::string::String {
        arg0.solver
    }

    public fun new(arg0: u128, arg1: vector<u8>, arg2: 0x1::string::String) : OrderFill {
        OrderFill{
            id          : arg0,
            order_bytes : arg1,
            solver      : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

