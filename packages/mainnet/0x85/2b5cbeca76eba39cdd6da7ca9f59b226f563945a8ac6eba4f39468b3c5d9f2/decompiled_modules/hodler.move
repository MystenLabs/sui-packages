module 0x852b5cbeca76eba39cdd6da7ca9f59b226f563945a8ac6eba4f39468b3c5d9f2::hodler {
    struct HODLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODLER>(arg0, 6, b"HODLER", b"TheLittelHodler", b"support the popularity and products of thelittlehodler, make $HODLER famous throughout the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047913_735709b1ed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HODLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

