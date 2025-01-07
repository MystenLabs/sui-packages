module 0x19cc5fbd3d10a3315594ccd8d4a211ef9a0d101be47c6ef0d44217699b8cb8cc::peen {
    struct PEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEN>(arg0, 6, b"PEEN", b"BallPeen", b"It's just a ball-peen hammer, a very useful thing indeed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730662184191.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

