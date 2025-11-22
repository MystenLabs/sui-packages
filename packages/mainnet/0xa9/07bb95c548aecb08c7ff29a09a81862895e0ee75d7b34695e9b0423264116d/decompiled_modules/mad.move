module 0xa907bb95c548aecb08c7ff29a09a81862895e0ee75d7b34695e9b0423264116d::mad {
    struct MAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"6030b0b88aa94dffe24b36c8c661563180f14c9ed2bd82c7431dc0e52891313f                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MAD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MAD         ")))), trim_right(b"MadDegen                        "), trim_right(x"244d41442020776865726520612063726f7764656420627562626c65206d61702069736e742061207761726e696e672c206974732070726f6f66206f6620636f6d6d756e69747920706f7765722e0a4d6f73742070726f6a6563747320736565206c6f7473206f6620636f6e6e65637465642077616c6c65747320616e64207468696e6b207768616c6573206f7220626f74732e204d41443f204974206d65616e73207265616c20686f6c646572732c207265616c20636f6e6e656374696f6e732c20616e64206120747275652c206163746976652065636f73797374656d2e0a0a4576657279206c696e6b65642077616c6c65742069732061206d656d6265722074726164696e672c20626f6e64696e672c20616e64206561726e696e67207265776172647320746f6765746865722e0a546865206d6f726520636f6e6e65"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAD>>(v4);
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

