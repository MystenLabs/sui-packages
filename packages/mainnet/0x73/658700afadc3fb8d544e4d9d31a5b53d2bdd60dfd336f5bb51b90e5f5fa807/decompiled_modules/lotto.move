module 0x73658700afadc3fb8d544e4d9d31a5b53d2bdd60dfd336f5bb51b90e5f5fa807::lotto {
    struct LOTTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOTTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOTTO>(arg0, 6, b"LOTTO", b"Lottery Token", b"LOTTO is a token that automatically enters all holders into a lottery once per day. LOTTO removes 1 token from all holders, pools those tokens together, and gives them to one random participant. The lottery occurs once every week. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735004041811.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOTTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOTTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

