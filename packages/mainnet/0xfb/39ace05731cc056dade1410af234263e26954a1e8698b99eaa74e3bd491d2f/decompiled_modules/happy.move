module 0xfb39ace05731cc056dade1410af234263e26954a1e8698b99eaa74e3bd491d2f::happy {
    struct HAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPPY>(arg0, 6, b"HAPPY", b"HAPPY COIN ", b"Happy Coin Catch the Vibe,Share the Joy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730787087023.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

