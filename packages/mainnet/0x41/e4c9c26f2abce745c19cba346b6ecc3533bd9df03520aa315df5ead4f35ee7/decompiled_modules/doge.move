module 0x41e4c9c26f2abce745c19cba346b6ecc3533bd9df03520aa315df5ead4f35ee7::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 8, b"DOGE", b"Wrapped Dogecoin", b"ABEx Virtual Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGE>>(v0);
    }

    // decompiled from Move bytecode v6
}

