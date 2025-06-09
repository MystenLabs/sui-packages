module 0x9720dfd0c02e47edc38522b4d1487fea4697bfabda881886d021f86dea2cf8f9::toilet {
    struct TOILET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOILET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOILET>(arg0, 6, b"TOILET", b"$TOILET ", x"42757920746865206469702c2074616b652061207368f09f92a9742c207468656e20776970652077697468206761696e7321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749502517909.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOILET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOILET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

