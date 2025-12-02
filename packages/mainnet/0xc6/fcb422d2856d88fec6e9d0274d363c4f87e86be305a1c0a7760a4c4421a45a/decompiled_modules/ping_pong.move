module 0x7438a2f45d1b5548df81e714cbe5bbcb77c0dd25198373acfae368634279d221::ping_pong {
    struct PingPong has copy, drop {
        from: address,
        amount: u64,
    }

    struct NestedData has copy, drop, store {
        label: 0x1::string::String,
        value: u64,
    }

    struct PongPing has copy, drop {
        val_u8: u8,
        val_u16: u16,
        val_u32: u32,
        val_u64: u64,
        val_u128: u128,
        val_u256: u256,
        val_bool_true: bool,
        val_bool_false: bool,
        val_address: address,
        val_string: 0x1::string::String,
        val_ascii: 0x1::ascii::String,
        val_vec_u8: vector<u8>,
        val_vec_u64: vector<u64>,
        val_vec_address: vector<address>,
        val_vec_string: vector<0x1::string::String>,
        val_vec_bool: vector<bool>,
        val_nested: NestedData,
        val_vec_nested: vector<NestedData>,
        val_empty_vec: vector<u8>,
        val_some: vector<u64>,
        val_none: vector<u64>,
    }

    public fun ping(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v2 = PingPong{
            from   : v0,
            amount : v1,
        };
        0x2::event::emit<PingPong>(v2);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0);
        0x1::vector::push_back<u64>(v4, 1);
        0x1::vector::push_back<u64>(v4, 2);
        0x1::vector::push_back<u64>(v4, 3);
        0x1::vector::push_back<u64>(v4, v1);
        0x1::vector::push_back<u64>(v4, 18446744073709551615);
        let v5 = 0x1::vector::empty<address>();
        let v6 = &mut v5;
        0x1::vector::push_back<address>(v6, v0);
        0x1::vector::push_back<address>(v6, @0x0);
        0x1::vector::push_back<address>(v6, @0x1);
        0x1::vector::push_back<address>(v6, @0x2);
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"first"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"second"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"third"));
        let v9 = NestedData{
            label : 0x1::string::utf8(b"nested_example"),
            value : 42,
        };
        let v10 = NestedData{
            label : 0x1::string::utf8(b"item_1"),
            value : 100,
        };
        let v11 = NestedData{
            label : 0x1::string::utf8(b"item_2"),
            value : 200,
        };
        let v12 = NestedData{
            label : 0x1::string::utf8(b"item_3"),
            value : 300,
        };
        let v13 = 0x1::vector::empty<NestedData>();
        let v14 = &mut v13;
        0x1::vector::push_back<NestedData>(v14, v10);
        0x1::vector::push_back<NestedData>(v14, v11);
        0x1::vector::push_back<NestedData>(v14, v12);
        let v15 = PongPing{
            val_u8          : 255,
            val_u16         : 65535,
            val_u32         : 4294967295,
            val_u64         : v1,
            val_u128        : (v1 as u128) * 1000000000000,
            val_u256        : (v1 as u256) * 1000000000000000000000000,
            val_bool_true   : true,
            val_bool_false  : false,
            val_address     : v0,
            val_string      : 0x1::string::utf8(x"48656c6c6f2c20496e6f6472612120f09f8e89"),
            val_ascii       : 0x1::ascii::string(b"Hello ASCII"),
            val_vec_u8      : x"007fff010203",
            val_vec_u64     : v3,
            val_vec_address : v5,
            val_vec_string  : v7,
            val_vec_bool    : vector[true, false, true, false],
            val_nested      : v9,
            val_vec_nested  : v13,
            val_empty_vec   : 0x1::vector::empty<u8>(),
            val_some        : vector[12345],
            val_none        : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<PongPing>(v15);
        arg0
    }

    // decompiled from Move bytecode v6
}

