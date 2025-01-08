module 0xc5d39e52eb9666e37ee9783f8a0b44132591f839a1528d25d6e120295a753f15::pepehit {
    struct PEPEHIT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPEHIT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPEHIT>>(0x2::coin::mint<PEPEHIT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PEPEHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2knnYCVfvuRwcoXE5MomvMfNzkxoxyhw5pJXDAUbEAq7.png?size=lg&key=9c66e5                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEPEHIT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEPEHIT ")))), trim_right(b"Pepe The Hitman                 "), trim_right(b"Pepe The Hitman- is a savage memecoin bringing killer vibes to crypto. No mercy, just gains! Join the squad and watch Pepe snipe his way to the moon!                                                                                                                                                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEHIT>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPEHIT>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPEHIT>>(0x2::coin::mint<PEPEHIT>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

