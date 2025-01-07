module 0xdca74914498e3fbade42585bac9d67868b358f95ba0a9182241d7a4cdf74d025::haha {
    struct HAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHA>(arg0, 9, b"HAHA", b" HAHA", b"H", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ceddd8c8-f9cc-4b77-a3a4-2805b18668e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

