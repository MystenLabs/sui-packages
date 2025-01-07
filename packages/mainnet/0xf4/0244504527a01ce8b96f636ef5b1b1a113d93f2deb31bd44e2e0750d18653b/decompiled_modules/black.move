module 0xf40244504527a01ce8b96f636ef5b1b1a113d93f2deb31bd44e2e0750d18653b::black {
    struct BLACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACK>(arg0, 9, b"BLACK", b"Essi", b"EssiBlack", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3899406-67a9-411f-9ea5-c8cda18065a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

