module 0xfa0f0ef26581618455cc3a2e52344bbbb07fd0a6619b4bf14752c56ede9cce5::ghost {
    struct GHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOST>(arg0, 6, b"GHOST", b"Sui Ghost", b"Did you see the ghost!? It ran through here and slimed me! This is ectoplasm!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_ezgif_com_video_to_gif_converter_e555c3af18.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

