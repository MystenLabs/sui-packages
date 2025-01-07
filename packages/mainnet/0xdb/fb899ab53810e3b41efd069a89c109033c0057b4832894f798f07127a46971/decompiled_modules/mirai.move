module 0xdbfb899ab53810e3b41efd069a89c109033c0057b4832894f798f07127a46971::mirai {
    struct MIRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIRAI>(arg0, 6, b"MIRAI", b"STUDIO MIRAI", x"56656e747572652073747564696f206275696c64696e67206e6578742d67656e65726174696f6e20636f6e73756d657220657870657269656e636573206f6e200a405375694e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960919525.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIRAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIRAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

