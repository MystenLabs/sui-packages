module 0x1ce3df4e1281a8e156a50f4b202f5fcb73030c91f4c7327a8f77bf96ee866b86::jailthem {
    struct JAILTHEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAILTHEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/145ud9xa7uFiQrfLKvA3kvmF8CZdpsvUD86Vy3EmJAiL.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JAILTHEM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JAILTHEM    ")))), trim_right(b"JailThemAll                     "), trim_right(x"244a41494c5448454d2020546865204d6f76656d656e7420666f72204a75737469636520696e2043727970746f21200a0a54686520534f4c2065636f73797374656d20686173206265636f6d65206120706c617967726f756e6420666f72207363616d6d65727372756773206c696b65204c696272612c204861776b547561682c205452554d502c204d454c414e49412c2042414c442c20616e64206d6f7265206861766520647261696e6564206d696c6c696f6e73207768696c6520746865207265616c2074726164657273207375666665722e20456e6f75676820697320656e6f7567682e0a0a20244a41494c5448454d2069736e74206a75737420616e6f74686572206d656d6520746f6b656e202d2069747320612073746174656d656e742e204120626174746c652063727920616761696e73742072756767657273"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAILTHEM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAILTHEM>>(v4);
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

