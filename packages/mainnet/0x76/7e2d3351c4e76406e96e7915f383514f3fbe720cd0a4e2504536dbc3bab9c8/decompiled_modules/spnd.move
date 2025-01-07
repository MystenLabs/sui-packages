module 0x767e2d3351c4e76406e96e7915f383514f3fbe720cd0a4e2504536dbc3bab9c8::spnd {
    struct SPND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPND>(arg0, 9, b"SPND", b"SPENDIT", b"SPENDIT is  Utility Token. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/13f770f0-4ed1-4b49-b78f-948fb58a3724.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPND>>(v1);
    }

    // decompiled from Move bytecode v6
}

