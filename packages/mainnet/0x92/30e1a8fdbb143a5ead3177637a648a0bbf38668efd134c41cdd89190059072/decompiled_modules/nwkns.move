module 0x9230e1a8fdbb143a5ead3177637a648a0bbf38668efd134c41cdd89190059072::nwkns {
    struct NWKNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NWKNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NWKNS>(arg0, 9, b"NWKNS", b"ksken", b"jdndn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6d2e75f9-e17a-427c-89de-38780cf45a71.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NWKNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NWKNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

