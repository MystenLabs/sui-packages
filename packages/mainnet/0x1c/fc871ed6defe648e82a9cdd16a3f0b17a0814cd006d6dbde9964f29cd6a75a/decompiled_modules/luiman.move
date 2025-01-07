module 0x1cfc871ed6defe648e82a9cdd16a3f0b17a0814cd006d6dbde9964f29cd6a75a::luiman {
    struct LUIMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUIMAN>(arg0, 6, b"LuiMan", b"LuigiMangione", b"Deny Defend Depose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733823308425.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUIMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUIMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

