module 0xc5d0ba21c65ce52ac69e35530fba8c0f60dfe27425b9c3ba09decd7d629c92c3::kendbvb {
    struct KENDBVB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENDBVB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENDBVB>(arg0, 9, b"KENDBVB", b"shiwje", b"djnsnwna", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d20f5793-92bb-422d-95db-89d680b27693.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENDBVB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KENDBVB>>(v1);
    }

    // decompiled from Move bytecode v6
}

