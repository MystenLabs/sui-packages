module 0x17e715bd83f2c3ae539c9904fb8698432b54b6b9cfd0d88d83db7cc5ce84b0e7::diddy {
    struct DIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDY>(arg0, 6, b"Diddy", b"Diddy over", b"Buy gohnson for Diddy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734625358975.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIDDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

