module 0xc86306c727491f41fa8a5783015bcc7ecf36ba409d39b214e87fc83c05de8843::censoor {
    struct CENSOOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CENSOOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"94d3583f0a0af3ca8c4d2305d6b83cd7d056cd25f25626483690fe8cf03b4312                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CENSOOR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"censoor     ")))), trim_right(b"Censoored COIN                  "), trim_right(x"43454e534f4f52454420206461206d656d65206461742045552066696c7465722063616e74206576656e20726561642070726f706572200a0a4272757373656c7320736179206d656d657320722064616e6765726f757320666f722064656d6f63726163792e0a46696c746572626f7473207363616e6e696e67207572206772616e646d61732063617420706963732e0a55706c6f61647320626c6f636b6564206265666f72652075206576656e20636c69636b20706f73742e0a4575726f70652077616e747320752071756965742e0a4575726f70652077616e74732075206f62656469656e742e0a0a536f207765206d6164652043454e534f4f524544200a746865206d656d6520752063616e206c6567616c6c79206f776e2062632074686520616c676f726974686d20746f6f2073747570696420746f207061727365"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CENSOOR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CENSOOR>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

