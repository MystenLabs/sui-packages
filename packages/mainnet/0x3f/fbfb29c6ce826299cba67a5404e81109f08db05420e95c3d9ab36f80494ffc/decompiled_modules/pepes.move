module 0x3ffbfb29c6ce826299cba67a5404e81109f08db05420e95c3d9ab36f80494ffc::pepes {
    struct PEPES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPES>(arg0, 6, b"PEPES", b"PEPESUI", b"TOTAL LP BURNED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739033927450.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

