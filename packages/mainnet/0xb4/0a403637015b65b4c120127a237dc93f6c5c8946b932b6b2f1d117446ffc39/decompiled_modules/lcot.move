module 0xb40a403637015b65b4c120127a237dc93f6c5c8946b932b6b2f1d117446ffc39::lcot {
    struct LCOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GS6Zag6XdRANcXWJ6hoUxcbaH2ZpFwCfWV1uS7Hwpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LCOT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LCOT        ")))), trim_right(b"Live Coin                       "), trim_right(x"4c69766520436f696e20697320612064796e616d69632063727970746f63757272656e637920626f726e20647572696e672061206c6976652073747265616d2c20656d626f6479696e6720696e6e6f766174696f6e20616e64207265616c2d74696d6520636f6d6d756e69747920656e676167656d656e742e204275696c74206f6e2074686520536f6c616e6120626c6f636b636861696e2c206974206f6666657273206c696768746e696e672d66617374207472616e73616374696f6e7320616e64206c6f7720666565732c206d616b696e672069742074686520696465616c206469676974616c20617373657420666f722063726561746f72732c20636f6d6d756e69746965732c20616e64206c69766520696e746572616374696f6e732e0a0a576974682069747320726f6f747320696e2073706f6e74616e65697479"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCOT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LCOT>>(v4);
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

