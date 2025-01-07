module 0x64c7dc546bffd04af207c54c025f7ab34c4813d9fcdb9b7ee42d6d4faf3b1c8::fyhfgf {
    struct FYHFGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FYHFGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FYHFGF>(arg0, 9, b"FYHFGF", b"Gfcyf", b"Dhchfgd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07e5ac70-4015-4453-b41f-a354c90b2954.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FYHFGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FYHFGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

