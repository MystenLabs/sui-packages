module 0x636a2ce3c5695ae4cd355f6336b7b261980da33887756c0d4d831e999779e83c::masui {
    struct MASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASUI>(arg0, 6, b"MASUI", b"MASUI CAT", b"MASUI - is a magical cat with a gold medallion that brings good luck.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Firefly_green_cat_golden_eyes_anime_nature_golden_medalion_21148_67a1b35caa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

