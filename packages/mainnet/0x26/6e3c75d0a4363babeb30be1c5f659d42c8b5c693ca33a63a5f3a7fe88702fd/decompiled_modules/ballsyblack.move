module 0x266e3c75d0a4363babeb30be1c5f659d42c8b5c693ca33a63a5f3a7fe88702fd::ballsyblack {
    struct BALLSYBLACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLSYBLACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLSYBLACK>(arg0, 6, b"BALLSYBLACK", b"BLACK BALLSY", b"Welcome to the new wave Ballsy Black", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250501_002044_05efbd37a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLSYBLACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALLSYBLACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

