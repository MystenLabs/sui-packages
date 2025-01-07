module 0x38f44a88668f92beb90c47eb6960c7ebd98145b81f4984dfb0174f6f1683a70f::ruk {
    struct RUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUK>(arg0, 9, b"RUK", b"Rukie", b"Ruktoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/293ccba0-3852-4098-9b87-f8de6862dcf1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

