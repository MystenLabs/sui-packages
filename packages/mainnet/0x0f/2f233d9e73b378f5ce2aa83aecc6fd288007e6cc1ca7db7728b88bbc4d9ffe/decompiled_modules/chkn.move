module 0xf2f233d9e73b378f5ce2aa83aecc6fd288007e6cc1ca7db7728b88bbc4d9ffe::chkn {
    struct CHKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHKN>(arg0, 6, b"CHKN", b"BigCock", b"Chicken McBiggom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739564834575.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHKN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHKN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

