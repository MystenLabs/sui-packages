module 0xb8c5c8cf75a40a802d755ef3b6baab244482cfe6a8d9cb9a8664ac8845796d19::nkts {
    struct NKTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NKTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NKTS>(arg0, 9, b"NKTS", b"Nikkytos", b"My own", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NKTS>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NKTS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NKTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

