module 0x71f3b8ff61015634eea6cc7db832315f3564d7988a1c976fc2197da1124f7c04::mansui {
    struct MANSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANSUI>(arg0, 6, b"MANSUI", b"MANATEE SUI", b"Don't forget to bring a Manatee !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_01_24_29_65df77d187.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

