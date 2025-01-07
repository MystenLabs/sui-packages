module 0xc551bd7d21c8d3ad2690e412351148013cdd4ce6c9edf24db1b165840b1658e0::orym {
    struct ORYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORYM>(arg0, 9, b"ORYM", b"ORYM", b"ORYM", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ORYM>(&mut v2, 9999999000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORYM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORYM>>(v1);
    }

    // decompiled from Move bytecode v6
}

