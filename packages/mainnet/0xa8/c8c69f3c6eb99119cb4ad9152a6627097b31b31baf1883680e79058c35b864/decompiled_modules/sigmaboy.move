module 0xa8c8c69f3c6eb99119cb4ad9152a6627097b31b31baf1883680e79058c35b864::sigmaboy {
    struct SIGMABOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGMABOY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4N5jkEmddTxtZQzjb4XowDJvHDzcxkByxMAf9Xa4bonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SIGMABOY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"sigmaboy    ")))), trim_right(b"Sigma Boy                       "), trim_right(x"54686520225369676d61626f7922206d656d652c2061207061726f6479206f662074686520227369676d61206d616c652c222069732062696720696e205275737369616e20696e7465726e65742063756c747572652e200a0a54686520736f6e67205369676d6120426f7920627920626c6f676765727320426574737920616e64204d617269612059616e6b6f76736b6179612c2072656c6561736564204f63746f62657220342c20323032342c2077697468206120596f755475626520766964656f2c2077656e7420766972616c20616e6420746f707065642053706f746966797320566972616c20353020476c6f62616c2063686172742e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGMABOY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIGMABOY>>(v4);
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

