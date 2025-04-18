module 0xdd2f0d46bbc617428024d878412ca5d0d0443a5c0a7d85cb5066860afa2e30be::sobrokea {
    struct SOBROKEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOBROKEA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DV4XFhwqgCRUcd88kAiG6g2zBdFGsS8C1Mq9nvqfpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SOBROKEA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SoBroke     ")))), trim_right(b"Sophucking Broke                "), trim_right(x"53686520676f742039392070726f626c656d7320616e64206576657279206f6e6520636f737473206d6f6e65792e20517565656e206f66206f76657264726166742e20496e76656e74656420627579206e6f772c20637279206c617465722e20426f756768742072616d656e2077697468204b6c61726e612e2053686573206e6f7420646f776e206261647368657320646f776e20636174617374726f706869632e204d616e6966657374696e67206d696c6c696f6e7320776974682024332e343720696e2068657220636865636b696e67206163636f756e7420616e64203120736f6c20616e64206120647265616d0a0a7e4c6f7665200a536f706875636b696e672042726f6b6520202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOBROKEA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOBROKEA>>(v4);
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

