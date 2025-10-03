module 0x45b19e2ed102894a9f06ce3b489c7bf680ca74ad0a5bca72165bd7a798c04f60::x402 {
    struct X402 has drop {
        dummy_field: bool,
    }

    fun init(arg0: X402, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"06ceeda519f4d7becc12e0be1736d3ff713b2cfecbdfa18a6f51e010e8514e6d                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<X402>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"X402        ")))), trim_right(b"X402                            "), trim_right(x"546865202a2a5834303220546f6b656e20282458343032292a2a20706f7765727320746865202a2a583430322050726f746f636f6c2a2a202061206e6578742d67656e65726174696f6e207061796d656e7420696e667261737472756374757265206275696c74206f6e20536f6c616e612e204279207265766976696e672074686520646f726d616e742048545450202a2a343032205061796d656e742052657175697265642a2a2073746174757320636f64652c205834303220656e61626c65732061207365616d6c6573732c206d616368696e652d6e6174697665207061796d656e74206c6179657220666f722074686520696e7465726e65742e0a0a4f6e20536f6c616e617320686967682d706572666f726d616e636520626c6f636b636861696e2c202458343032207472616e73666f726d7320686f77202a2a4149"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X402>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<X402>>(v4);
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

