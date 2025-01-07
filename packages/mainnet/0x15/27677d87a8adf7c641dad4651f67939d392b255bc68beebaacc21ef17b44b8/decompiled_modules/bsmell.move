module 0x1527677d87a8adf7c641dad4651f67939d392b255bc68beebaacc21ef17b44b8::bsmell {
    struct BSMELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSMELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSMELL>(arg0, 6, b"BSMELL", b"Buttsmell", b"AI Agent ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735803659187.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSMELL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSMELL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

