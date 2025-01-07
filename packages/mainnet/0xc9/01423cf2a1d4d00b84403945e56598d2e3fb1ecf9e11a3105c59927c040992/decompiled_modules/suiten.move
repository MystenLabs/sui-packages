module 0xc901423cf2a1d4d00b84403945e56598d2e3fb1ecf9e11a3105c59927c040992::suiten {
    struct SUITEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEN>(arg0, 6, b"SUITEN", b"suitengri", b"that's it. It's really", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733435504357.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

