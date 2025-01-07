module 0x2aebd2f717a644ea3462a92d87db3f4b932f8917787fa4630f718cfd7511a374::asdasd {
    struct ASDASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDASD>(arg0, 9, b"ASDASD", b"ASADS", b"CVBCVBDFF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f754999f-ec9e-4d7b-9f42-5f1e8216cfc3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDASD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDASD>>(v1);
    }

    // decompiled from Move bytecode v6
}

