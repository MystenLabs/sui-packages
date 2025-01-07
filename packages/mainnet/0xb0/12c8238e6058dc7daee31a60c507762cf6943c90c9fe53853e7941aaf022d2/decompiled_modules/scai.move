module 0xb012c8238e6058dc7daee31a60c507762cf6943c90c9fe53853e7941aaf022d2::scai {
    struct SCAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAI>(arg0, 6, b"SCAI", b"SECURITY AI", b"This token is the token that will be used to pay for the security bot that we will soon release on our website. It can be obtained shortly in a daily login that we are developing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735912481393.03")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

