module 0x197cb1d75e57810402abd3c1871ae7dc8e4488c37c3a915a4d1dd5f6bba95e55::elun_doge {
    struct ELUN_DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELUN_DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELUN_DOGE>(arg0, 6, b"ELUN DOGE", b"Elun Doge", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELUN_DOGE>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELUN_DOGE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ELUN_DOGE>>(v2);
    }

    // decompiled from Move bytecode v6
}

