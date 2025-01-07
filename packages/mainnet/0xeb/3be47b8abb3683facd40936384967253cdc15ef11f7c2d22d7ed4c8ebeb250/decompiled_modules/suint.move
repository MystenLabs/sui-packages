module 0xeb3be47b8abb3683facd40936384967253cdc15ef11f7c2d22d7ed4c8ebeb250::suint {
    struct SUINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINT>(arg0, 6, b"SUINT", b"Suin't", b"Not Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_10_ezgif_com_video_to_gif_converter_1f185ac11e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

