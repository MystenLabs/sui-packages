module 0x6ba76ce7c23702794f05e97a474a2d950f1c311d7c9271e7a6b6c716da983ed4::suibeer {
    struct SUIBEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBEER>(arg0, 6, b"SUIBEER", b"SUIBeer", x"44455620495320524f4152494e47204452554e4b2c204245204341524546554c2e286a7573742061206a6f6b653a44292054472069732072656e65770a504c414e3a54656c656772616d2f582f576562736974652f6d6179626520736f6d65207370616d206d61726b6574696e67207c207468616e2050554d50212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pngtree_imported_beer_cartoon_drink_png_image_4559553_303bdd4baf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

