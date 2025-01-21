module 0x5e97f4da6f9ca95523f73e561417321189e5fb322a3b9215374c9b4c285731e::czxczx {
    struct CZXCZX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZXCZX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CZXCZX>(arg0, 6, b"CZXCZX", b"cxzcxzcx by SuiAI", b"czxcxz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_22_at_00_53_53_9feb7dc85b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CZXCZX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZXCZX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

