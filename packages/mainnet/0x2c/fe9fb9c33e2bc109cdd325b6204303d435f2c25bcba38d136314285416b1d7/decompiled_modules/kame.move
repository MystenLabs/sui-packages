module 0x2cfe9fb9c33e2bc109cdd325b6204303d435f2c25bcba38d136314285416b1d7::kame {
    struct KAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"jSEfdhEqa6jBM6rI                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KAME>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Kame        ")))), trim_right(b"Kame Coin                       "), trim_right(x"4b616d6520436f696e2069732061206d656d6520636f696e2064656469636174656420746f20686f6e6f72696e6720746865206c6567656e6461727920416b69726120546f726979616d612c207468652063726561746976652067656e69757320626568696e64202a447261676f6e2042616c6c2a2c202a44722e20536c756d702a2c20616e64206f746865722069636f6e696320776f726b732e20496e7370697265642062792074686520737069726974206f6620616476656e747572652c20737472656e6774682c20616e642068756d6f72207468617420646566696e656420546f726979616d6173206372656174696f6e732c204b616d6520436f696e20656d626f646965732074686520706f776572206f66206e6f7374616c67696120616e6420636f6d6d756e6974792e20200d0a0d0a576974682061206e616d65"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAME>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAME>>(v4);
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

