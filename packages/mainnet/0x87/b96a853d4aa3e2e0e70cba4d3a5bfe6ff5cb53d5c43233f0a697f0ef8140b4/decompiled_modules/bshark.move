module 0x87b96a853d4aa3e2e0e70cba4d3a5bfe6ff5cb53d5c43233f0a697f0ef8140b4::bshark {
    struct BSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BSHARK>(arg0, 6, b"BSHARK", b"BullShark by SuiAI", x"f09f9a8020416476616e63656420536e6970657220426f74202b20f09fa496204149204167656e74202b20f09f96bc2044796e616d696320504650204e465473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/BASH_5c3c206411.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BSHARK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSHARK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

