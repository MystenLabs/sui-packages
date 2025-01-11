module 0xe11bba8b2563c36567819dcf0dd7dbda471ed645f7795e716129b736f945aedc::suin {
    struct SUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIN>(arg0, 6, b"SUIN", b"SUIN by SuiAI", b"SUIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/20250110_225201_3b78be52e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

