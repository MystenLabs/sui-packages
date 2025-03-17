module 0x7a65b909eba89f2256762022e89290bebb666d24c72df4071a80f1d0842fdc38::gipsy {
    struct GIPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIPSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIPSY>(arg0, 9, b"GIPSY", b"Gipsy", b"Gipsy Danger coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf61255c-da59-4eb1-8f7d-f701c3824e80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIPSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIPSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

