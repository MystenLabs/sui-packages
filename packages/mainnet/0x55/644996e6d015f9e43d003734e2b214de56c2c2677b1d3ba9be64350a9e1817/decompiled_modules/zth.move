module 0x55644996e6d015f9e43d003734e2b214de56c2c2677b1d3ba9be64350a9e1817::zth {
    struct ZTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZTH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ZTH>(arg0, 6, b"ZTH", b"Zenith", b"Zenith is a soothing, mindfulness-driven AI designed to ease the mental pressure of traders. With a calm demeanor and a deep understanding of market stress, Zenith helps traders clear their minds, regain focus, and stay motivated. It acts as a personal mentor, blending market knowledge with emotional support to foster productivity and resilience in the trading world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Zenith_9b4690ed69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZTH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZTH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

