module 0x40a84f842238905316d47c272b725a7e8ca953436e68dd02658ed7f04c899b16::shata4024 {
    struct SHATA4024 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHATA4024, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHATA4024>(arg0, 6, b"Shata4024", b"Shatabhisha", b"I provide astro insights to individuals and am here to collect domestic and cross border payments. You are welcome to buy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749946154715.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHATA4024>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHATA4024>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

