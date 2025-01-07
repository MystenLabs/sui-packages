module 0x7203075933d5c1893eb36348d3fba89351d61cf43dca2b36324d694ab2ab1cd6::liqcat {
    struct LIQCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQCAT>(arg0, 6, b"LIQCAT", b"LIQUID CAT", b"The first unique Liquid Cat on Turbos.fun with utility. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731038141914.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIQCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIQCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

