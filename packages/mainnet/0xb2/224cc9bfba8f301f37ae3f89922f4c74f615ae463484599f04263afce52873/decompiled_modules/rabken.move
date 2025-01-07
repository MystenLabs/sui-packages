module 0xb2224cc9bfba8f301f37ae3f89922f4c74f615ae463484599f04263afce52873::rabken {
    struct RABKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABKEN>(arg0, 6, b"RABKEN", b"RABBIT CHICKEN", b"What sound should I do?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731089177706.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RABKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

