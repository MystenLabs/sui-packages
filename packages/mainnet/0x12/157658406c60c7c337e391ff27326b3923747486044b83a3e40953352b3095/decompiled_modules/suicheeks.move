module 0x12157658406c60c7c337e391ff27326b3923747486044b83a3e40953352b3095::suicheeks {
    struct SUICHEEKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHEEKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHEEKS>(arg0, 6, b"SUICHEEKS", b"TySUI Cheeks", b"This is the moment we knew Mike Tyson was going to whop Jake paul. History was written but it started with TySUI Cheeks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731732305115.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICHEEKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHEEKS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

