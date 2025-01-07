module 0x19c3cb4b0ee2bd3e61ac8b7723c8d5672205dab752786e2076f190c347cdb156::chillgod {
    struct CHILLGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLGOD>(arg0, 6, b"CHILLGOD", b"Phillips Banks", b"With a smirk as steady as Bitcoin's volatility, $CHILLGOD promises investors one thing: absolute vibes, no guarantees.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732669792831.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLGOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLGOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

