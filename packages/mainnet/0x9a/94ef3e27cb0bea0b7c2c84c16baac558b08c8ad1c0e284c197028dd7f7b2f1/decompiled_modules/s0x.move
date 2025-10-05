module 0x9a94ef3e27cb0bea0b7c2c84c16baac558b08c8ad1c0e284c197028dd7f7b2f1::s0x {
    struct S0X has drop {
        dummy_field: bool,
    }

    fun init(arg0: S0X, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"64155b2e7341315a7df9075fabd55f9082f8a362d86e3b1e28d8a1f4cf26efff                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<S0X>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"s0x         ")))), trim_right(b"sonar                           "), trim_right(x"4f6e2d636861696e206d6164652073696d706c652e200a0a506f776572656420627920536f6c616e61200a0a41736b2061626f757420616e79207472616e73616374696f6e2c2077616c6c65742c206f7220746f6b656e20666c6f77202067657420696e7374616e7420616e737765727320696e20706c61696e20456e676c6973682e0a0a205363616e2077616c6c65747320616e6420636f6e74726163742061646472657373657320776974686f7574206576657220746f756368696e67206120626c6f636b206578706c6f7265722e0a0a20556e6465727374616e64206f6e2d636861696e20616374697669747920636c6561726c79206e6f206e6f6973652c206e6f206861736865732c206e6f20636f6e667573696f6e2e0a0a205472616465206469726563746c792066726f6d20746865206167656e742077697468"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S0X>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S0X>>(v4);
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

