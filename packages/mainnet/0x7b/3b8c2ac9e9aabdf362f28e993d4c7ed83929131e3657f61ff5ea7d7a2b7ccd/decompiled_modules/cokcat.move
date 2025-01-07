module 0x7b3b8c2ac9e9aabdf362f28e993d4c7ed83929131e3657f61ff5ea7d7a2b7ccd::cokcat {
    struct COKCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: COKCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COKCAT>(arg0, 6, b"COKCAT", b"COKCAT SUI ", b"COOK CAT real life Cat has become an extension of his whimsical universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731000541081.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COKCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COKCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

