module 0x69a5538157937bc1cf8a9cc31e9ce163ade48bd758d68d5d062aaa8a9ad3683c::church {
    struct CHURCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHURCH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HsDv8KcSFecpBLv8MHL686MoaFtQb68KRsjziZibc777.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHURCH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHURCH      ")))), trim_right(b"House Of God                    "), trim_right(x"486f757365204f6620476f64206465706c6f796564206f6e2068656176656e2e0a48656176656e20697320616e20414d4d20616e64206c61756e63687061642064657369676e656420746f20686f757365206772656174206964656173206f6e20536f6c616e612e204f6e6520706c61636520666f722065766572797468696e6720746f206c6976652c2066726f6d206d656d657320746f20636f6d70616e6965732e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHURCH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHURCH>>(v4);
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

