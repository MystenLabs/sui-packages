module 0x6770fca256559db0219a9b79391d173daa26d1b476009ad2be15f5d7241171ce::aamoo {
    struct AAMOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAMOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAMOO>(arg0, 6, b"AAMOO", b"aaa MOO DENG", b"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731916407234.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAMOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAMOO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

