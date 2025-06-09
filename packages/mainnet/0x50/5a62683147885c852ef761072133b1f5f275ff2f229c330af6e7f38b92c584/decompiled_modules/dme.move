module 0x505a62683147885c852ef761072133b1f5f275ff2f229c330af6e7f38b92c584::dme {
    struct DME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"cba8a44cb6b90d9a64af2f72f8b6111e44c17353516de191a854e5675dc4b72b                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DME>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DME         ")))), trim_right(b"DarkMatterEsports               "), trim_right(x"416c7265616479206c61756e63686564206f6e207468652043726f6e6f7320636861696e207375636365737366756c6c792066726f6d2067726164756174696e672c2077652061696d20746f206265206d756c74692d636861696e2c20617320776520617265206d756c74692d67616d696e672e0a0a4f6666696369616c2063727970746f20666f7220746865204461726b204d6174746572204573706f727473206672616e63686973652e204465666c6174696f6e617279206d6f64656c207468726f7567686f757420616c6c20636861696e73207468726f756768207765656b6c79204573706f727420746f75726e616d656e74732066726f6d206f7572206d656d626572732e0a0a43616c6c696e6720616c6c2067616d6572732c2063617375616c206f7220636f6d70657469746976652e0a0a4c6561726e206d6f72"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DME>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DME>>(v4);
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

