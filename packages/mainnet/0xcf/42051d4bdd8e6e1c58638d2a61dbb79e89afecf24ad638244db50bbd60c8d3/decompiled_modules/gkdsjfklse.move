module 0xcf42051d4bdd8e6e1c58638d2a61dbb79e89afecf24ad638244db50bbd60c8d3::gkdsjfklse {
    struct GKDSJFKLSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GKDSJFKLSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GKDSJFKLSE>(arg0, 9, b"GKDSJFKLSE", b"sjfekdbffj", b"SDEKLJGLSEF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/268f945f-7212-4ed5-9ade-549d04bc7a0b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GKDSJFKLSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GKDSJFKLSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

