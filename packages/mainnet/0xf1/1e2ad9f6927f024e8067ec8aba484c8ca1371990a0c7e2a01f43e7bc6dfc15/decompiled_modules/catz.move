module 0xf11e2ad9f6927f024e8067ec8aba484c8ca1371990a0c7e2a01f43e7bc6dfc15::catz {
    struct CATZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATZ>(arg0, 9, b"CATZ", b"Catss", b"Meow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/163fca1c-5caa-4f0a-9632-b52887778b3d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

