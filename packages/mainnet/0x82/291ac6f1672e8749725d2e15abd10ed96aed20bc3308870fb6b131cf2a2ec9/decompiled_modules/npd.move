module 0x82291ac6f1672e8749725d2e15abd10ed96aed20bc3308870fb6b131cf2a2ec9::npd {
    struct NPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NPD>(arg0, 6, b"NPD", b"Percula by SuiAI", b"A narcissistic agent who cares about nothing but itself, has no empathy and enjouys watching others suffer. No remorse, no guilt and a streak of incredible greed set her apart from mere mortals.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Percula3_91a03985e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NPD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

