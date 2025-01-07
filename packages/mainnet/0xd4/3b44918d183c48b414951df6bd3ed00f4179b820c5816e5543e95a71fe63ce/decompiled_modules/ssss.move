module 0xd43b44918d183c48b414951df6bd3ed00f4179b820c5816e5543e95a71fe63ce::ssss {
    struct SSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSSS>(arg0, 6, b"ssss", b"ddd", b"sadsdsad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBGKQ13Y6FNVNTP0JMBHCN76/01JBGR09HJNY9NM2T2TH9288DT")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SSSS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

