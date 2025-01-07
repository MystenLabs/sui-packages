module 0x44d9be9c7a903e0f4ef32fcacd1d39d00fb6b0e963f7e31d2dae3f29de7707da::gc {
    struct GC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GC>(arg0, 9, b"GC", b"Game Club", b"Telegram mini app entusiast community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2cd4b566-2d5c-45e3-a485-fc9a72b2bd62.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GC>>(v1);
    }

    // decompiled from Move bytecode v6
}

