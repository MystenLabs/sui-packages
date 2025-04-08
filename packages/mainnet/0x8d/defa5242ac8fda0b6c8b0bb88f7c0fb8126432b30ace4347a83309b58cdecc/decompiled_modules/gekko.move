module 0x8ddefa5242ac8fda0b6c8b0bb88f7c0fb8126432b30ace4347a83309b58cdecc::gekko {
    struct GEKKO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GEKKO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GEKKO>>(0x2::coin::mint<GEKKO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GEKKO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8Yfz1TYuKxh4WYJARLA2FY8EBUhpsg6YvKNGad1BUF9u.png?size=lg&key=3d06b9                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GEKKO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GEKKO   ")))), trim_right(b"Gekko                           "), trim_right(b"CoinGecko's new mascot                                                                                                                                                                                                                                                                                                          "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEKKO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GEKKO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GEKKO>>(0x2::coin::mint<GEKKO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

