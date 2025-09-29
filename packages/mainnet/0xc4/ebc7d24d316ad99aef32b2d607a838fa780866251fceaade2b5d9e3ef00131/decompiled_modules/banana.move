module 0xc4ebc7d24d316ad99aef32b2d607a838fa780866251fceaade2b5d9e3ef00131::banana {
    struct BANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"8c4b39ab9ce98b19276f5c28bd16f067f6a9e5af6b0b1bd30054d1d8e6867c5a                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BANANA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Banana      ")))), trim_right(b"Banana                          "), trim_right(b"Born in the trenches of crypto Twitter. Forged in the fires of Pump,fun. $BANANA isn't just a memecoin  IT'S A LIFESTYLE! We're the degens who diamond hand through -90%. We're the apes who buy the bag and HODL to Valhalla. We're the believers who know that fundamentals are for boomers and MEMES ARE FOREVER! No VCs, no "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANANA>>(v4);
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

