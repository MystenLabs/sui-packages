module 0xa53184c473b0adddc47a51b8d786ecd696bae7db593c4131a9ead99fe3e12282::fluffy {
    struct FLUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFY>(arg0, 6, b"FLUFFY", b"TURBO FLUFFY", b"https://furiesfluffy.com/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730972943565.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLUFFY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

