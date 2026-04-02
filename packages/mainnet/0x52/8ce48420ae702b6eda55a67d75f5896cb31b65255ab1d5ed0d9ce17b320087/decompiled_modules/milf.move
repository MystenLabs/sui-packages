module 0x528ce48420ae702b6eda55a67d75f5896cb31b65255ab1d5ed0d9ce17b320087::milf {
    struct MILF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILF>(arg0, 6, b"MILF", b"MilF", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MILF>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MILF>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MILF>>(v2);
    }

    // decompiled from Move bytecode v6
}

