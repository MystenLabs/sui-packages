module 0x5e48529267625c8a6087fe716ea2a1677b6c0c5b2850eeafde496c88d9f9e82b::chinn {
    struct CHINN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHINN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHINN>>(0x2::coin::mint<CHINN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CHINN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/acRm4yvx3ogqQbWgT5aamTt945p2RKkrDB2iLX2pump.png?size=lg&key=bcd0ca                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHINN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Chinn   ")))), trim_right(b"Chill Ninja                     "), trim_right(b"From this moment, the legend begins. This is the first step on our path, a journey written in stealth, strength, and precision. The $Chinn ninja fam is ready to carve its mark in history.                                                                                                                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHINN>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHINN>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHINN>>(0x2::coin::mint<CHINN>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

