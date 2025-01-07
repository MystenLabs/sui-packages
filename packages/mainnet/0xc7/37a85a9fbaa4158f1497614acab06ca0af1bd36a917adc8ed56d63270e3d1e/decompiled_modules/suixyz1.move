module 0xc737a85a9fbaa4158f1497614acab06ca0af1bd36a917adc8ed56d63270e3d1e::suixyz1 {
    struct SUIXYZ1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXYZ1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIXYZ1>(arg0, 9, b"SUIXYZ1", b"SUIXYZ1", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIXYZ1>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIXYZ1>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXYZ1>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

