module 0x9809347435672f6d1f4b8330b6bcc9919f37180dc7de0368840a1b371aada585::monaco {
    struct MONACO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONACO>(arg0, 6, b"MONACO", b"Monaco Club", b"Tired of meme coins named after animals? Monaco Club is for those seeking something greater. We arent chasing the hype, but carving out a niche for those who value wealth and leisure. While others scramble for quick gains, Monaco embraces elegance and exclusivity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Monaco_3_dff156f845.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONACO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONACO>>(v1);
    }

    // decompiled from Move bytecode v6
}

