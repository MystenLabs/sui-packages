module 0x18c10f8738c37c6a98049960c424416ef43e5ebc59e64079ed6e5eef0a78ae42::unknown {
    struct UNKNOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNKNOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNKNOWN>(arg0, 6, b"UNKNOWN", b"Unknown AI", b"Unknown AI is an innovative token featuring a mysterious, incognito-style AI chat. Designed to answer any question.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kp_ezgif_com_video_to_gif_converter_215b883f00.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNKNOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNKNOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

