module 0xd87f6e850894a89ca8ffd52f1ffc217c95357335acb943c7870d8dbe1c6c0086::chilldog {
    struct CHILLDOG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHILLDOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHILLDOG>>(0x2::coin::mint<CHILLDOG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CHILLDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3vpkxR5mmLHSorBu8AtkrRETr9CWTmU2fKoaGnd9Vdoj.png?size=lg&key=552d9d                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHILLDOG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHILLDOG")))), trim_right(b"Just a chill Doge               "), trim_right(b"ChillDOG is the project for those who know how to enjoy the crypto journey without chasing the hype. No FOMO, no unnecessary stressjust buy DOGE, kick back, and relax.                                                                                                                                                         "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLDOG>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHILLDOG>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHILLDOG>>(0x2::coin::mint<CHILLDOG>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

