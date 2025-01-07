module 0x2d935d56349e60ede9d68b73848d2c5c2116b3afa806da503e1ee8b28c81ac96::bonokun {
    struct BONOKUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONOKUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONOKUN>(arg0, 6, b"BONOKUN", b"BONO KUN", x"424f4e4f2d4b554e207c204b41424f5355275320424f59465249454e440a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3563_d3c2806fd9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONOKUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONOKUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

