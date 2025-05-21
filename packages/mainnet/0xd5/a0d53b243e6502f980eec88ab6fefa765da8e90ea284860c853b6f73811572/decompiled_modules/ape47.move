module 0xd5a0d53b243e6502f980eec88ab6fefa765da8e90ea284860c853b6f73811572::ape47 {
    struct APE47 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<APE47>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<APE47>>(0x2::coin::mint<APE47>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: APE47, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0xd79a8c33e95e576159427cfcafd325c40361bd40.png?size=lg&key=526255                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<APE47>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"APE47   ")))), trim_right(b"ApeWifAK47                      "), trim_right(b"LITERALLY JUST AN APE WIF AN AK-47 ITS A SYMBOL OF UNHINGED DEGEN ENERGY, A LOUDER-THAN-LIFE FORCE THAT BLASTS THROUGH THE OLD FINANCIAL SYSTEM. LOCKED, LOADED, AND READY TO SEND, WIF AIMS STRAIGHT AT THE FUTURE, WHERE ONLY THE WILDEST SURVIVE.                                                                            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APE47>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<APE47>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<APE47>>(0x2::coin::mint<APE47>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

