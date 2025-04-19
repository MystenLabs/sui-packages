module 0x1d1d7956983a71985be079b2b00563461cfb2fd85521e17a9cb3a4b456dc74f5::shawwal {
    struct SHAWWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAWWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3Mtp5V2wEZ92oYjkgbKNwy3idB9wG9UdaHcTSLdcpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SHAWWAL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Shawwal     ")))), trim_right(b"Shawwal                         "), trim_right(x"4d55534c494d2043525950544f20544f4b454e530a50524553454e54530a5348415757414c2e0a50696f7573204d75736c696d73206661737420696e205368617777616c2c207468652069736c616d69632063616c656e646172206d6f6e74682061667465722052616d6164616e2e0a0a46617374696e672052616d6164616e20616e6420746865207369782064617973206973206c696b652066617374696e67206f6e6520636f6d706c65746520796561722e0a0a41204d75736c696d2043727970746f20546f6b656e206c61756e63682e20486f6c646572732077696c6c206e65766572206265207275676765642e205765622c20544720636f6d6d756e69747920616e6420582077696c6c206265206865726520666f72657665722e202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAWWAL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAWWAL>>(v4);
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

