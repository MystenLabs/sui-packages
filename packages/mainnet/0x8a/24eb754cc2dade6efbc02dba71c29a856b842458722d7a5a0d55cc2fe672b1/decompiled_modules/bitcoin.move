module 0x8a24eb754cc2dade6efbc02dba71c29a856b842458722d7a5a0d55cc2fe672b1::bitcoin {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOIN>(arg0, 9, b"BITCOIN", b"Hposinu10 ", b"Harry Potter Obama Sonic Inu 10 on Wave ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ccd540fe-5420-4143-968b-f0508a4dd098.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

