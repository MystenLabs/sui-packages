module 0x32cfcd245956a1450219ec5e23ef107df6d58a9413dda7d8ca1231ca3c5ad99c::gizmo {
    struct GIZMO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GIZMO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GIZMO>>(0x2::coin::mint<GIZMO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GIZMO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0x5dc5f832399cfaab094122afd5d1f8d720fb021c.png?size=lg&key=564209                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GIZMO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GIZMO   ")))), trim_right(b"GIZMO IMAGINARY KITTEN          "), trim_right(b"$GIZMO - JUST MEME, MEOW.                                                                                                                                                                                                                                                                                                       "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIZMO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GIZMO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GIZMO>>(0x2::coin::mint<GIZMO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

