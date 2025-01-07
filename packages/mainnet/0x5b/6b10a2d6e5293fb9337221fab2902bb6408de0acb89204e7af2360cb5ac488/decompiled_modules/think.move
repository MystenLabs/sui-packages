module 0x5b6b10a2d6e5293fb9337221fab2902bb6408de0acb89204e7af2360cb5ac488::think {
    struct THINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: THINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THINK>(arg0, 6, b"Think", b"Just Think About It", b"[REDACTED]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731253034183.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THINK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

