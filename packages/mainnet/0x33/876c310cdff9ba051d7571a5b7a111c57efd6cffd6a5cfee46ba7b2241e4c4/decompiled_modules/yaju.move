module 0x33876c310cdff9ba051d7571a5b7a111c57efd6cffd6a5cfee46ba7b2241e4c4::yaju {
    struct YAJU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAJU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/RceVwPi7z0azLLcAD7rHTulFfj9CXBe9JjhLXayf4Jk";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/RceVwPi7z0azLLcAD7rHTulFfj9CXBe9JjhLXayf4Jk"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<YAJU>(arg0, 9, trim_right(b"Yaju"), trim_right(b"Yaju  "), trim_right(x"52657370656374204a6170616e6573652063756c747572652e0a4275696c64206f6e205375692e0a0a4265796f6e64203131343531342e0a4265796f6e642053454e50414920636f696e732e0a0a47726f77746820737461727473206e6f772e0a496b757a6f2e"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (1000000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<YAJU>>(0x2::coin::mint<YAJU>(&mut v5, 1000000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAJU>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<YAJU>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAJU>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

