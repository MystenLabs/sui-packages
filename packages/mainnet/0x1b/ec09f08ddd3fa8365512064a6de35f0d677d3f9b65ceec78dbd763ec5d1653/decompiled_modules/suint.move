module 0x1bec09f08ddd3fa8365512064a6de35f0d677d3f9b65ceec78dbd763ec5d1653::suint {
    struct SUINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINT>(arg0, 6, b"SUINT", b"Suin't", b"Not Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_10_ezgif_com_video_to_gif_converter_f4cdd06a1b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

