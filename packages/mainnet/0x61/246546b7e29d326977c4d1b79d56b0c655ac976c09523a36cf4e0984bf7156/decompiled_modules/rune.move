module 0x61246546b7e29d326977c4d1b79d56b0c655ac976c09523a36cf4e0984bf7156::rune {
    struct RUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUNE>(arg0, 6, b"RUNE", b"WATER RUNE", b"Water Rune. Sui Rune? :)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_15_d0e7d07f94.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

