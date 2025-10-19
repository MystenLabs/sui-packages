module 0xe86c038c8dd3bca4b4ff0c3343e0c27ef08181f73c1b0e3385c2559f52287db9::knw {
    struct KNW has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"45a39e1e8c262719e84918007d2d9ec969f416199f0daedec87e2d61d26ae678                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KNW>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KNW         ")))), trim_right(b"KNOWLEDGE                       "), trim_right(x"244b4e5720697320746865206669727374206d656d6520636f696e2074686174207265776172647320796f757220627261696e2e20457665727920726f756e642c20686f6c6465727320626174746c65206974206f757420696e20666173742d706163656420747269766961202035206d696e757465732c2031302d7365636f6e64207175657374696f6e732c20616e64206f6e652077696e6e65722074616b657320353025206f66207468652063726561746f7220666565732066726f6d207468617420726f756e642e200a0a546865206f7468657220353025206973206465706f736974656420746f2074686520747265617375727920666f72206d61726b6574696e6720707572706f7365732e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNW>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KNW>>(v4);
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

