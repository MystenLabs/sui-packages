module 0x34edbacdafa103394ecd18fc26746b90b2210afd912fabc5d86d4d9fcd41796a::dro {
    struct DRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRO>(arg0, 6, b"DRO", b"Droopy", b"Wuff wufff Droopy sending!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731002818082.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

