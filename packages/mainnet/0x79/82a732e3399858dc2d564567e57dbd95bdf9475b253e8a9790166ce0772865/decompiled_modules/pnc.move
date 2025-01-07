module 0x7982a732e3399858dc2d564567e57dbd95bdf9475b253e8a9790166ce0772865::pnc {
    struct PNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNC>(arg0, 9, b"PNC", b"Pinky Cat", b"just buy pinky in size of your pinky she is shy and fragile", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c9c5c7b-9173-4c70-b116-b045ed18f216.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

