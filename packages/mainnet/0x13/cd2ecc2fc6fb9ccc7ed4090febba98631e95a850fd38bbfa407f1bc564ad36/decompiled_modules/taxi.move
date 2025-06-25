module 0x13cd2ecc2fc6fb9ccc7ed4090febba98631e95a850fd38bbfa407f1bc564ad36::taxi {
    struct TAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/G6Nrz5YzBiLatyDERTBdDz86LxYCvvMoeNqcHyVdYEik.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TAXI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TAXi        ")))), trim_right(b"TAXi Harold                     "), trim_right(x"57656c636f6d6520746f2054415869204861726f6c642e20496620796f752068617665206d6164652069742068657265207468656e20796f75206172652061626f757420746f20656d6261726b206f6e206120726f616420747269702061726f756e642074686520776f726c6420776974682054415869204861726f6c64206173206865206a6f75726e657973207468726f75676820616c6c203720636f6e74696e656e74732064726976696e672070617373656e6765727320746f2074686569722064657374696e6174696f6e7320616e64206d616b696e672073757265207468657920686176652061206c6175676820616c6f6e6720746865207761792e200a0a42757920796f7572205441586920746f6b656e7320616e642072656365697665204841524f4c4420746f6b656e73206173207265666c656374696f6e73"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAXI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAXI>>(v4);
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

