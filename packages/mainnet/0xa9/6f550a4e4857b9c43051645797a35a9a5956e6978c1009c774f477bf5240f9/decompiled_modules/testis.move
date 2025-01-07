module 0xa96f550a4e4857b9c43051645797a35a9a5956e6978c1009c774f477bf5240f9::testis {
    struct TESTIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTIS>(arg0, 9, b"Testis", b"Testis", b"Testis contract for launchpad", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTIS>>(v1);
        0x2::coin::mint_and_transfer<TESTIS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTIS>>(v2);
    }

    // decompiled from Move bytecode v6
}

