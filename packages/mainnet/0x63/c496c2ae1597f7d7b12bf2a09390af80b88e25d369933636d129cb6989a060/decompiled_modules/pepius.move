module 0x63c496c2ae1597f7d7b12bf2a09390af80b88e25d369933636d129cb6989a060::pepius {
    struct PEPIUS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPIUS>, arg1: 0x2::coin::Coin<PEPIUS>) {
        0x2::coin::burn<PEPIUS>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<PEPIUS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEPIUS>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PEPIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GpzuEnXNqmNTUfWBn4oYHP8u3641WxQR3Zn88BnGjja2.png?size=lg&key=4b080b                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEPIUS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEPIUS    ")))), trim_right(b"Pepius Maximus                  "), trim_right(b"Born of Elon Musks decree, Pepius Maximus rises as the emperor of memes, a beacon of glory in the crypto empire. With the strength of legions and the favor of the gods, its triumph is inevitable. Stand with greatnesshail Pepius Maximus!                                                                                    "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPIUS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPIUS>>(v5);
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

