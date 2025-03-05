module 0xae393c0adaf7da076ce4e39caffc7847463d33c72d6626e9f2a5525af86f4380::moist {
    struct MOIST has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOIST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOIST>>(0x2::coin::mint<MOIST>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOIST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0xa36d3cc9d45b77189696476eb82022e09747e085.png?size=lg&key=06054e                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MOIST>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MOIST   ")))), trim_right(b"Moist                           "), trim_right(b"Whether navigating the vast ocean or splashing about in a puddle, $MOIST is all about embracing fluidity and going with the flow. Inspired by Matt Furie, $MOIST embodies a fun-loving spirit that never dries up. Join $MOIST in making a big splash in the crypto world, one drop at a time.                                  "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOIST>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOIST>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOIST>>(0x2::coin::mint<MOIST>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

