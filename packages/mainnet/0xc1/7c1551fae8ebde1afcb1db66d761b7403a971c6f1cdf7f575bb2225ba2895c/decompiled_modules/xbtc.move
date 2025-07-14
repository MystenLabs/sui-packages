module 0xc17c1551fae8ebde1afcb1db66d761b7403a971c6f1cdf7f575bb2225ba2895c::xbtc {
    struct XBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: XBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XBTC>(arg0, 6, b"xBTC", b"Xtra Bitcoin", b"Ride the wave to millionaire!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752533751396.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

