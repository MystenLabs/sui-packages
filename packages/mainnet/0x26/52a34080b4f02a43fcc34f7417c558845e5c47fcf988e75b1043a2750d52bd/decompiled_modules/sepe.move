module 0x2652a34080b4f02a43fcc34f7417c558845e5c47fcf988e75b1043a2750d52bd::sepe {
    struct SEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEPE>(arg0, 6, b"SEPE", b"Meme token SEPE", b"Meme token for SuiVision", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240913_201110_332_7aec2049d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

