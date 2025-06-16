module 0xdc524a498fdeb260682cd50a59e027f52253d4e1d44f3c7f94dbf20e54796f41::wife {
    struct WIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DaUwvjjyGVuaFAFCi7D4cUB64nGvEJXgsMrkJKmn4Fwh.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WIFE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WIFE        ")))), trim_right(b"Wife Changing Money             "), trim_right(x"57696665204368616e67696e67204d6f6e6579202d2024574946450a506f77657265642062792040686f746d6f6d736f6c0a0a57696665204368616e67696e67204d6f6e65792069736e74206a757374206120746f6b656e69747320796f75722073686f742061742070656163652c206c6f76652c20616e64206d617962652061206e657720636f7563682e204275696c7420666f7220647265616d6572732c206d656d65206c6f7264732c20616e6420616e796f6e65207469726564206f66206578706c61696e696e6720746f207468656972206769726c2077687920746865797265207374696c6c20686f6c64696e672074686174206f6e65206261672e204275792024574946452e205361766520796f75722072656c6174696f6e736869702e2020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFE>>(v4);
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

