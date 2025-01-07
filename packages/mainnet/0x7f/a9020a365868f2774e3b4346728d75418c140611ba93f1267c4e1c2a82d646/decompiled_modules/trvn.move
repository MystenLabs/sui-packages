module 0x7fa9020a365868f2774e3b4346728d75418c140611ba93f1267c4e1c2a82d646::trvn {
    struct TRVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRVN>(arg0, 9, b"TRVN", b"TREVIN TOCEN", b"USA", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRVN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRVN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

