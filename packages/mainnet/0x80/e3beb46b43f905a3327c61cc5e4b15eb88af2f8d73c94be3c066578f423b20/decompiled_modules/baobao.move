module 0x80e3beb46b43f905a3327c61cc5e4b15eb88af2f8d73c94be3c066578f423b20::baobao {
    struct BAOBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAOBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GeBCL92LPDysZPFYjRkPe7cK42Vb4ehHPZCTtCSwja7w.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BAOBAO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BAOBAO      ")))), trim_right(b"BaoBao Panda                    "), trim_right(x"42414f2042414f2050414e44410a4d454d4520434f494e204348414d50494f4e204f462053504545440a426c696e6b2c20616e6420796f75276c6c206d697373206974210a0a496e206120776f726c64206f6620736c756767697368206d61726b65747320616e6420626f72696e67206d656d65732c206f6e65206865726f20726973657320746f20746865206368616c6c656e67652e2042616f2042616f2050616e64612c2074686520666173746573742070616e646120616c6976652c206973206865726520746f20627265616b207265636f7264732c2073686174746572206578706563746174696f6e732c20616e64206c6561766520616c6c20646f75627465727320656174696e67206869732064757374212020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAOBAO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAOBAO>>(v4);
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

