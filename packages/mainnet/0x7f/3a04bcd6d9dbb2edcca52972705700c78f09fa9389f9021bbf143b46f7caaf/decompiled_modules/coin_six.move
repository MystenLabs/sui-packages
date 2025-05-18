module 0x7f3a04bcd6d9dbb2edcca52972705700c78f09fa9389f9021bbf143b46f7caaf::coin_six {
    struct COIN_SIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_SIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_SIX>(arg0, 9, b"coinsix", b"coin six", b"coin six desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9000/kappa/kappa/coins/ed12f0e3-6975-4387-b3c0-de4375c488f2.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_SIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_SIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

