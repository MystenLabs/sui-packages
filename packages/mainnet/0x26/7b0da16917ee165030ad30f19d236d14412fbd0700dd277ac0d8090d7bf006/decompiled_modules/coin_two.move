module 0x267b0da16917ee165030ad30f19d236d14412fbd0700dd277ac0d8090d7bf006::coin_two {
    struct COIN_TWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_TWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_TWO>(arg0, 9, b"cointwo", b"coin two", b"coin two description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9000/kappa/kappa/coins/0e552b6f-6e94-4c9d-aac9-c8a9c9677080.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_TWO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_TWO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

