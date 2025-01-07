module 0x2e32073478193dd6d9a1bc524563f0b33f8f11ce6a9bb777adf2ece7ae521181::pepeto {
    struct PEPETO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPETO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPETO>>(0x2::coin::mint<PEPETO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PEPETO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2LRsj1iPCBEJoUoHsVAXKenWCRE95wtc4gyc7NoEqUdN.png?size=lg&key=03e49b                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEPETO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEPETO  ")))), trim_right(b"PEPETO                          "), trim_right(b"Who is the god of frogs Pepeto returns with true powerTechnology and Optimization. He holds the missing pieces Pepe could never understand. Beyond strength, Pepeto brings wisdom and unity, creating an exchange that adopts all memecoins, giving them real value and a place to thrive.                                      "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPETO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPETO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPETO>>(0x2::coin::mint<PEPETO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

