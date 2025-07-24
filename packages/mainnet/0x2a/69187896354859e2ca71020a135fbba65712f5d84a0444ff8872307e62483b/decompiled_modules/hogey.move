module 0x2a69187896354859e2ca71020a135fbba65712f5d84a0444ff8872307e62483b::hogey {
    struct HOGEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOGEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOGEY>(arg0, 6, b"Hogey", b"Hulk Hokey", b"Rips shirts in half for funzies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753373439446.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOGEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOGEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

