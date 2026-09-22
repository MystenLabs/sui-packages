module 0xacc59d039a66cb8ae8416bfa496dda821983a802bf3759059eaff9e586a749df::brent {
    struct BRENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRENT>(arg0, 6, b"BRENT", b"Brent Crude Oil", b"ZO Virtual Coin for Brent Crude Oil (BRENTOIL)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRENT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BRENT>>(v0);
    }

    // decompiled from Move bytecode v7
}

