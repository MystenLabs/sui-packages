module 0xf5f784e28c7307b92fefa510dee92a92068a1c92751d150580443e61cea7ee91::gvm {
    struct GVM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GVM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GVM>(arg0, 9, b"GVM", b"give me", b"the give me coin is for bull run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4a9ee1d-8faf-4ef4-a61c-a3d17abd53a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GVM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GVM>>(v1);
    }

    // decompiled from Move bytecode v6
}

