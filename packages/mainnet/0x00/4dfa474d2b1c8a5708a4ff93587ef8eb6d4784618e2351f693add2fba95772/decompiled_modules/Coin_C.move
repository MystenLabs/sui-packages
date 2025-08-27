module 0x4dfa474d2b1c8a5708a4ff93587ef8eb6d4784618e2351f693add2fba95772::Coin_C {
    struct COIN_C has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_C>(arg0, 9, b"COINC", b"Coin C", b"Coin C Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9090/kit/TemporaryCoinAvatar/01K3PH2Z9DP860YSGYYYYW6F69.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_C>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_C>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

