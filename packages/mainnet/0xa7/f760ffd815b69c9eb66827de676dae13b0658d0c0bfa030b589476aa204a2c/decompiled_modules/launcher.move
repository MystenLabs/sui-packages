module 0xa7f760ffd815b69c9eb66827de676dae13b0658d0c0bfa030b589476aa204a2c::launcher {
    struct LAUNCHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAUNCHER>(arg0, 9, b"ODYSSEY", b"ODY", b"Odyssey Launcher Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAUNCHER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAUNCHER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

