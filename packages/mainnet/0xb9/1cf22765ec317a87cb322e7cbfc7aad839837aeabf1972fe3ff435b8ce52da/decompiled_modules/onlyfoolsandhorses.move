module 0xb91cf22765ec317a87cb322e7cbfc7aad839837aeabf1972fe3ff435b8ce52da::onlyfoolsandhorses {
    struct ONLYFOOLSANDHORSES has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONLYFOOLSANDHORSES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONLYFOOLSANDHORSES>(arg0, 9, b"ONLYFOOLSANDHORSES", b"OFAH", b"The trotters", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ONLYFOOLSANDHORSES>>(0x2::coin::mint<ONLYFOOLSANDHORSES>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ONLYFOOLSANDHORSES>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ONLYFOOLSANDHORSES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

