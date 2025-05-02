module 0x2cbd58c305ee636b06411474a567faee17b9ab270a9a649b9c4a80e4654aadfb::skksks {
    struct SKKSKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKKSKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKKSKS>(arg0, 6, b"SKKSKS", b"asdasd", b"asdasdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746224683922.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKKSKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKKSKS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

