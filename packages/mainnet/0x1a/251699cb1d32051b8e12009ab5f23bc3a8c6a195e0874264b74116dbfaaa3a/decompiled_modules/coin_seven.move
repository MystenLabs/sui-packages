module 0x1a251699cb1d32051b8e12009ab5f23bc3a8c6a195e0874264b74116dbfaaa3a::coin_seven {
    struct COIN_SEVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_SEVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_SEVEN>(arg0, 9, b"coinseven", b"coin seven", b"coin seven desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9000/kappa/kappa/coins/7fe709c5-1710-44a5-a1b3-d79195447cd6.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_SEVEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_SEVEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

