module 0x332bc3d2e9631b16523ed4b2af5c288451a1584cc1dda932fb835a13799501c2::gold {
    struct GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLD>(arg0, 6, b"GOLD", b"glod", b"dense lustrous yellow precious metal of Group 11 (Ib), Period 6, of the periodic table of the elements. Gold has several qualities that have made it exceptionally valuable throughout history.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gold_1aa7c37610.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

