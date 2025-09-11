module 0x2e9068cfd1bb8e98790ce418a28f5af1a631a4b1fae42ad70e2af2e3c953e1b::busd {
    struct BUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"8a4a185cb787b00eea76594efb18a9baa2d95fad1f0af9c3928922fe9d00e065                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BUSD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BUSD        ")))), trim_right(b"Bonk Bucks                      "), trim_right(x"426f6e6b204275636b732028244255534429202074686520756e6f6666696369616c2063757272656e6379206f662074686520424f4e4b206d656d657665727365210a0a426f726e2066726f6d2074686520536f6c616e61206d656d652063756c747572652c20426f6e6b204275636b732069732061206c69676874686561727465642079657420636f6d6d756e697479202d2064726976656e2070726f6a6563742064657369676e656420746f2072657761726420637265617469766974792c20656e636f75726167652074726164696e672066756e2c20616e6420756e69746520424f4e4b2066616e7320756e646572206f6e652062616e6e65722e0a0a576974682074686520636f6d6d756e697479206e6f77206174207468652068656c6d2c202442555344206973206265696e672072657669766564207769746820"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUSD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUSD>>(v4);
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

