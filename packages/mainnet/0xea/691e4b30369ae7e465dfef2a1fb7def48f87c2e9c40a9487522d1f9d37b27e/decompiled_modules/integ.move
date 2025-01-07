module 0xea691e4b30369ae7e465dfef2a1fb7def48f87c2e9c40a9487522d1f9d37b27e::integ {
    struct INTEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: INTEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INTEG>(arg0, 6, b"INTEG", b"Integrate AI ", b"IntegrateAl is building Al powered solutions for optimising data flow.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735284608433.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INTEG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INTEG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

