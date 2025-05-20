module 0xb7a0d896b6e594f4043b731c432520aa24df75a96e1d26baa2f4f6baf657e807::dolphin {
    struct DOLPHIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOLPHIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DOLPHIN>>(0x2::coin::mint<DOLPHIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DOLPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HfFfDrsMjLVB12XVBEAKaajanb1Qrd1qVLxgdfSpump.png?size=lg&key=e7980a                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOLPHIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DOLPHIN ")))), trim_right(b"DOLPHIN by Matt Furies          "), trim_right(b"DOLPHIN isnt here to do tricks. Hes here to dominate. Born in the depths of sarcasm and bred in the riptides of chaos, this blue menace isnt splashing for fun. He bites, mocks, and flips through charts like a feral sea god with nothing to lose.                                                                            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLPHIN>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOLPHIN>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DOLPHIN>>(0x2::coin::mint<DOLPHIN>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

