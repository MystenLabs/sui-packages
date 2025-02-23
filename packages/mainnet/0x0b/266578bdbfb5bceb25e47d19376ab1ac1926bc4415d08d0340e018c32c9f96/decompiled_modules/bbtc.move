module 0xb266578bdbfb5bceb25e47d19376ab1ac1926bc4415d08d0340e018c32c9f96::bbtc {
    struct BBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BJvb2NzHwTbTK64qvarRutp48qicwEWUCHmnpidJYBMb.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BBTC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"bbtc        ")))), trim_right(b"Blue Bitcoin                    "), trim_right(x"4d65657420426c756520426974636f696e20284242544329200a746865206d656d6520636f696e2077697468206120636f6f6c20626c7565207477697374210a4275696c74206f6e20536f6c616e6120776974682061203231206d696c6c696f6e20737570706c792c0a2069742773206c696b6520426974636f696e2c206275742077697468206d6f72652066756e20616e6420612073706c617368206f6620626c756520636f6c6f722e20466173742c2066756e6b792c20616e6420616c6c2061626f757420746865206d656d65206d61676963202d206a756d7020696e20616e6420726964652074686520426c756520426974636f696e2077617665212020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBTC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBTC>>(v4);
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

