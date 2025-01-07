module 0xb88c8f14ea78ff1104c682eabbbc6b5b82249c67d45757759d92fc28cfe6423::hihi {
    struct HIHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIHI>(arg0, 9, b"HIHI", b"WEIWEI", b"Hi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c6c51bd-d8cb-4214-8fdf-ea13957a44f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

