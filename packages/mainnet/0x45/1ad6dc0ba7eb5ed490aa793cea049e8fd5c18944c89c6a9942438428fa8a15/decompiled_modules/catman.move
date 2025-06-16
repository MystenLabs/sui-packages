module 0x451ad6dc0ba7eb5ed490aa793cea049e8fd5c18944c89c6a9942438428fa8a15::catman {
    struct CATMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EoPhR1V5Zo9avH5FbWTDmyfsmTbu3cnWFoQg89wvpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CATMAN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Catman      ")))), trim_right(b"Catman                          "), trim_right(x"4361746d616e206279204d617474204675726965200a2843726561746f72206f6620506570652c2042726574742c20416e64206f746865722069636f6e6963206d656d652066696775726573292e0a0a0a0a43656e7472616c697365642065786368616e6765206c697374696e672873290a50726573616c65202846696e6973686564290a0a0a41206f726967696e616c2073746f72792064726976656e206d656d652077697468204e46542c20486f6c64657220726577617264732c2041697264726f70732c20436f6e746573747320616e64206d6f72652e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATMAN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATMAN>>(v4);
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

