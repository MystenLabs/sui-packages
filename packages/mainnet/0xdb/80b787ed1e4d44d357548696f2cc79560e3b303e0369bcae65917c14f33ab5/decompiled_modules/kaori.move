module 0xdb80b787ed1e4d44d357548696f2cc79560e3b303e0369bcae65917c14f33ab5::kaori {
    struct KAORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAORI>(arg0, 9, b"KAORI", b" KAORI", b"KA O RI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31a6bb1e-3336-44f5-bbbe-fe5bdb15d927.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAORI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAORI>>(v1);
    }

    // decompiled from Move bytecode v6
}

