module 0x24393b8b82b374567b46cb1444395332abf3467c5d957089fc218f302c772ab3::gafieldcat {
    struct GAFIELDCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAFIELDCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAFIELDCAT>(arg0, 6, b"GafieldCat", b"Gafed", b"funny Cat Gafield!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_03_09_14_03_45_fotor_bg_remover_20240925113258_fotor_20240925113437_0554bcb90e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAFIELDCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAFIELDCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

