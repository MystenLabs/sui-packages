module 0xd917ec56b0d652d258698dd6d9dbfa4f539cff909fb44287e93086d4f78e3e5e::cape {
    struct CAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"fca1fab70714834b422f96a9f91cf29b3cc33b9de0e83ee852734ec740a9bc14                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CAPE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CAPE        ")))), trim_right(b"99 Dev Skill Cape               "), trim_right(b"Grinding Development to 99. Live. On stream. No bullshit. Building Hyperscape - a real AI-powered MMORPG where ElizaOS agents  fight alongside humans. RuneScape-style combat, skills, and progression. Everything AI-generated: items, mobs, lore, 3D models. This isn't vaporware. The game is playable RIGHT NOW. Clone the r"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPE>>(v4);
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

