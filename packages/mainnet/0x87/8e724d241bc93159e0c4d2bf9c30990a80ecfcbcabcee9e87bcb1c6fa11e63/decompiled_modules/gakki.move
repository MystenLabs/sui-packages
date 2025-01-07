module 0x878e724d241bc93159e0c4d2bf9c30990a80ecfcbcabcee9e87bcb1c6fa11e63::gakki {
    struct GAKKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAKKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAKKI>(arg0, 6, b"Gakki", b"YUI", b"Yui Aragaki is the cutest in the world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730907832251.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAKKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAKKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

