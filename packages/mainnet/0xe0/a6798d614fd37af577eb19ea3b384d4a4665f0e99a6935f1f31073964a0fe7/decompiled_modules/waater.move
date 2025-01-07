module 0xe0a6798d614fd37af577eb19ea3b384d4a4665f0e99a6935f1f31073964a0fe7::waater {
    struct WAATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAATER>(arg0, 6, b"Waater", b"WaterH", b"https://t.me/waterherosui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_12_20_29_21_96c0c33e48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

