module 0xa5a616d2fac448e4f5fefbbdc7bd70f820e9ca00926955ccfb75e600be0b9904::samezu {
    struct SAMEZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMEZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMEZU>(arg0, 6, b"SAMEZU", b"Samezu", b"Get onboard with $SAMEZU and surf the big waves with the coolest shark crew in town. Dont be left high and drygrab your share of $SAMEZU before its off to the next big crypto reef!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_1_3203cee380.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMEZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMEZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

