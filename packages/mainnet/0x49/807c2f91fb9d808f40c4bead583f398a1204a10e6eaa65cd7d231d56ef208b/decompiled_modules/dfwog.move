module 0x49807c2f91fb9d808f40c4bead583f398a1204a10e6eaa65cd7d231d56ef208b::dfwog {
    struct DFWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFWOG>(arg0, 6, b"DFWOG", b"Deep Seek Fwog", b"DeepSeek Fwog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250129_134648_119_7849127636.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DFWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

