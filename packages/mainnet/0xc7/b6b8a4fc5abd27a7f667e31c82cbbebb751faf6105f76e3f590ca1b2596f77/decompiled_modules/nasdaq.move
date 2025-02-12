module 0xc7b6b8a4fc5abd27a7f667e31c82cbbebb751faf6105f76e3f590ca1b2596f77::nasdaq {
    struct NASDAQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NASDAQ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DFUhdc8YXzeENeGaSJrus5yYfKsq978oCcxfqgJnQ5ap.png?claimId=LGG2mkHlr3dX6yjn                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NASDAQ>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NASDAQ      ")))), trim_right(b"NASDAQ                          "), trim_right(x"546865205472757374656420466162726963206f66207468652046696e616e6369616c2053797374656d0a0a506f736974696f6e656420617420746865206e65787573206f6620746563686e6f6c6f677920616e6420746865206361706974616c206d61726b6574732c204e61736461712070726f7669646573207072656d69657220706c6174666f726d7320616e6420736572766963657320666f7220676c6f62616c206361706974616c206d61726b65747320616e64206265796f6e64207769746820756e6d61746368656420746563686e6f6c6f67792c20696e73696768747320616e64206d61726b657473206578706572746973652e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NASDAQ>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NASDAQ>>(v4);
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

