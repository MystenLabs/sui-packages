module 0x385c8baeba2a3e125da2f09146ecbd6a237c7ee1e2d84c159b4806f94fee31ad::happy {
    struct HAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPPY>(arg0, 9, b"Happy", b"HAPPY COIN ", b"Just fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/63d2bdd8341979957ccf4e14d7874ab6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

