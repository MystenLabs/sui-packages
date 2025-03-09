module 0x5f8412c421a3112289e19553a8180621afa6e290fd9c2f61d8128332688fdc12::trn {
    struct TRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CrxD7dNZ5zSpoThRWnfm1tZZoC6zStjtcDcJspBXLPoW.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TRN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TRN         ")))), trim_right(b" TRITHON                        "), trim_right(x"57656c636f6d6520546f2054726974686f6e0a444e532026204950204c65616b20446574656374696f6e20466561747572657320696e2054726974686f6e2056504e0a4f6e6c696e652070726976616379206973206372756369616c2c20616e64206d616e792056504e20757365727320776f7272792061626f75742064617461206c65616b73206578706f73696e672073656e73697469766520696e666f206c696b65204950206164647265737365732e20576974682054726974686f6e2056504e2c20796f7572652070726f746563746564206279207265616c2d74696d6520444e5320616e64204950206c65616b20646574656374696f6e20706f776572656420627920616476616e63656420414920746563686e6f6c6f67792c20656e737572696e6720796f757220707269766163792e2020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRN>>(v4);
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

