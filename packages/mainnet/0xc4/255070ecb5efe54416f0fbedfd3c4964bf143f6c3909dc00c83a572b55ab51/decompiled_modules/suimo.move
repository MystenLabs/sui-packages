module 0xc4255070ecb5efe54416f0fbedfd3c4964bf143f6c3909dc00c83a572b55ab51::suimo {
    struct SUIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMO>(arg0, 6, b"SUIMO", b"Suimo Japanese", x"69732061206d656d6520746f6b656e20696e737069726564206279204a6170616e6573652063756c747572652c2053554d4f0a0a54656c656772616d3a2068747470733a2f2f742e6d652f7375696d6f6f6e7375690a547769747465723a2068747470733a2f2f782e636f6d2f53554d4f4f4e5355490a576562736974653a2068747470733a2f2f7375696d6f7375692e6d792e63616e76612e736974652f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul29_20241219172143_5f2f2f85d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

