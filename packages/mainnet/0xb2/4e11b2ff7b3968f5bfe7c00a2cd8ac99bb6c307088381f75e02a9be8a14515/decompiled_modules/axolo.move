module 0xb24e11b2ff7b3968f5bfe7c00a2cd8ac99bb6c307088381f75e02a9be8a14515::axolo {
    struct AXOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXOLO>(arg0, 6, b"Axolo", b"Hugo Axolotl", b"Hugo is here to be cute as hell and fuck shit up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730993594909.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AXOLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXOLO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

