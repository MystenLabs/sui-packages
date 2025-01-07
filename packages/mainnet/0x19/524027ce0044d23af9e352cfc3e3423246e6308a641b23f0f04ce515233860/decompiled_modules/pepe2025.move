module 0x19524027ce0044d23af9e352cfc3e3423246e6308a641b23f0f04ce515233860::pepe2025 {
    struct PEPE2025 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPE2025>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPE2025>>(0x2::coin::mint<PEPE2025>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PEPE2025, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/FZZNyjG0SDZ0IQH6?width=150&height=150&fit=crop&quality=95&format=auto                                                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEPE2025>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEPE2025")))), trim_right(b"FIRST 2025 PEPE                 "), trim_right(b"Step into the celebration with Pepe, the timeless icon, ringing in 2025 in spectacular style!  With a champagne glass in hand and fireworks lighting up the night sky, Pepe embodies festive energy and new beginnings.                                                                                                         "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE2025>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPE2025>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPE2025>>(0x2::coin::mint<PEPE2025>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

