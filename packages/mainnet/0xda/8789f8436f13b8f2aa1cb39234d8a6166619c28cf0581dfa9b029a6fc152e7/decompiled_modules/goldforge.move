module 0xda8789f8436f13b8f2aa1cb39234d8a6166619c28cf0581dfa9b029a6fc152e7::goldforge {
    struct GOLDFORGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDFORGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"342abdd3a4a622478ba977b5f663117e5327eaa14a83aee61096cbb5b7714ecc                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GOLDFORGE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GOLDFORGE   ")))), trim_right(b"Gold Forge                      "), trim_right(x"476f6c6420466f726765207c2024474f4c44464f5247450a0a416e20245841557430202854657468657220476f6c6429207265776172647320746f6b656e206f6e20536f6c616e612e204576657279207472616e73616374696f6e207072696e74732033252054657468657220476f6c64207265776172647320737472616967687420746f20796f75722077616c6c65742e0a0a486f6c642024474f4c44464f52474520616e64206561726e202458415574302023474f4c44206576657279203130206d696e7574657320202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDFORGE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDFORGE>>(v4);
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

