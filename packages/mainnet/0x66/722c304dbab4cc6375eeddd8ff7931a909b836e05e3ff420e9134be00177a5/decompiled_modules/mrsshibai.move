module 0x66722c304dbab4cc6375eeddd8ff7931a909b836e05e3ff420e9134be00177a5::mrsshibai {
    struct MRSSHIBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRSSHIBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRSSHIBAI>(arg0, 6, b"MRSSHIBAI", b"MRS SHIBAI", b"Mrs. SHIB ai's vision is clear: to establish a stable and thriving ecosystem where meme coins can flourish. She dreams of a world where market cap surpasses the 1M mark, where a strong community and a dedicated team drive innovation and development. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753143784226.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRSSHIBAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRSSHIBAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

