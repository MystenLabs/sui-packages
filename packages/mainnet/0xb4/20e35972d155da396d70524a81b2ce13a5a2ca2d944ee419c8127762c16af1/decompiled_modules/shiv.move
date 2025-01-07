module 0xb420e35972d155da396d70524a81b2ce13a5a2ca2d944ee419c8127762c16af1::shiv {
    struct SHIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIV>(arg0, 9, b"SHIV", x"536869766120756ec3a0", b"Utility and tokenize asset", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d0c74131-14b7-4c58-b6e2-03d628854fbc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIV>>(v1);
    }

    // decompiled from Move bytecode v6
}

