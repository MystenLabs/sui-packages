module 0x27990b12151404eb90dd3c8613e2d6ac22e45f3300c73aaffb75f8eb1008c393::suisan {
    struct SUISAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAN>(arg0, 6, b"SUISAN", b"susan on sui", b"suisan is a fully sentient AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250112_053530_751_f1c35bac9a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

