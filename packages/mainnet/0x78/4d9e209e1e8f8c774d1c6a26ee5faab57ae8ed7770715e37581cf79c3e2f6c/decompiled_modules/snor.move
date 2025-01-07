module 0x784d9e209e1e8f8c774d1c6a26ee5faab57ae8ed7770715e37581cf79c3e2f6c::snor {
    struct SNOR has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SNOR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SNOR>>(0x2::coin::mint<SNOR>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SNOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9X6ki2FYScBRisLTmhj43buEMTUvJ754FZwCct1dpump.png?size=lg&key=43696f                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SNOR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SNOR    ")))), trim_right(b"Snorlax                         "), trim_right(b"The chillest meme coin on Sui! Nap, fight, and dance your way to the moon with Snorlex, now part of the legendary meme ecosystem.                                                                                                                                                                                               "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNOR>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SNOR>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SNOR>>(0x2::coin::mint<SNOR>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

