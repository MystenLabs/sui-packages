module 0x15559746dcb4220f85a358bd993c00e01dde02e6e024357415b88457562f173c::revs {
    struct REVS has drop {
        dummy_field: bool,
    }

    fun init(arg0: REVS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9VxExA1iRPbuLLdSJ2rB3nyBxsyLReT4aqzZBMaBaY1p.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<REVS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"REVS        ")))), trim_right(b"REVSHARE                        "), trim_right(x"4c61756e636820596f757220536f6c616e6120546f6b656e2077697468205265765368617265204c61756e63687061642e0a5768657468657220796f75277265206c6f6f6b696e6720746f206c61756e6368204a61636b706f7420546f6b656e732c20526577617264732f5265666c656374696f6e732054617820546f6b656e732c204c6f747465727920546f6b656e732c20526567756c617220546f6b656e732c206f72206576656e204c61756e63684c616220426f6e64696e6720437572766520546f6b656e732020776527766520676f7420796f7520636f76657265642e0a526576536861726520697320746865206d6f737420696e6e6f766174697665206c61756e6368706164206f6e20536f6c616e612c2065766f6c76696e67206461696c7920616e6420676976696e672063726561746f727320706f77657266"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REVS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REVS>>(v4);
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

