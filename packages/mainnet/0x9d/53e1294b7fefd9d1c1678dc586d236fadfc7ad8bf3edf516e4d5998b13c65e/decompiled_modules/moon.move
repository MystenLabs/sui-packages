module 0x9d53e1294b7fefd9d1c1678dc586d236fadfc7ad8bf3edf516e4d5998b13c65e::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 6, b"MOON", b"Harvest Moon", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOON>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOON>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOON>>(v2);
    }

    // decompiled from Move bytecode v6
}

