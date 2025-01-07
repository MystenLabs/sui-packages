module 0xbd565a8718183fed275fbb51b4686d870051c4140dd19e10f28c5f577cb733c9::launch {
    struct LAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAUNCH>(arg0, 6, b"LAUNCH", b"NS LAUNCH SOON", b"The NS token will launch in 24 hours! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731495995148.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAUNCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAUNCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

