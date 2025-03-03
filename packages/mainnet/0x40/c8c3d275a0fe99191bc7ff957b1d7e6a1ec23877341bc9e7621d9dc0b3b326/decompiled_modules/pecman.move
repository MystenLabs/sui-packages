module 0x40c8c3d275a0fe99191bc7ff957b1d7e6a1ec23877341bc9e7621d9dc0b3b326::pecman {
    struct PECMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PECMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x64b9a967e6461210f06b259148b58c401ef3d19c0f207c03d9fa85542acdcb71::pecman::pecman.png?size=lg&key=461dac                                                                                                                                                                         ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PECMAN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PECMAN  ")))), trim_right(b"PECMAN                          "), trim_right(b"Pacman with Pepe the Frogs face is a humorous and unique combination, where Pacman retains his round shape but has the expressive face of Pepe the Frog, creating a character that is both familiar and novel.                                                                                                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PECMAN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PECMAN>>(v4);
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

