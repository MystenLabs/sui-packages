module 0xf4eb4de137537bb7550e33cbacf61c3f3130e7f2a9f41657209a11b5bdec69a5::suimeocat {
    struct SUIMEOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEOCAT>(arg0, 9, b"SUIMEOCAT", b"Suimeo cat", b"Rizz cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c6271ab-3bce-4a0e-b54a-215d1a454bde.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

