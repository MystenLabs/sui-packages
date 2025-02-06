module 0x746645bf50a7032b108ec19e636359bdfb06644b03c960c1d77332b45dd6e9ff::stake {
    struct STAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"RE5cVU2QCKOnx0a8                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<STAKE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Stake       ")))), trim_right(b"STAKE.US                        "), trim_right(x"5374616b6520697320746865206f6666696369616c20746f6b656e206f6620746865205374616b652e757320776562736974652e0d0a0d0a506c6179207468652062657374206f6e6c696e6520636173696e6f2067616d65732c20736c6f74732026206c69766520636173696e6f2067616d65732c206f7220626574206f6e2073706f727473206174205374616b652e75732120556e6c6f636b2056495020626f6e757365732c2062657420776974682063727970746f20616e642077696e20626967207072697a65732e0d0a0d0a546f70203230206d6f6f6e73686f7420686f6c646572732077696c6c2072656365697665206120626f6e7573206f662024353030206f6e204665627275617279203674682c206166746572206c697374696e67206f6e207261796469756d2e20416e6e6f756e63656d656e7420636f6d69"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAKE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAKE>>(v4);
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

