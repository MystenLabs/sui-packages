module 0xa82471a138fa0e9fd664e5bd73b8662b05896887b8a75dd3ea6d47727d1cff87::hots {
    struct HOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOTS>(arg0, 9, b"HOTS", b"HOT", b"HOT TRADING TOKEN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f784f856-20e5-4c2c-8776-3bccb6352dd2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

