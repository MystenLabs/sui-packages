module 0x700b225c46a05b2602625ca8d5bb0e3177cef4026c3ff8b7ae9a22353d97a869::scats {
    struct SCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCATS>(arg0, 9, b"SCATS", b"SuiCats", b"The world of Sui Cats.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3b8d1a0-046f-469d-a4ff-02969a32103d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

