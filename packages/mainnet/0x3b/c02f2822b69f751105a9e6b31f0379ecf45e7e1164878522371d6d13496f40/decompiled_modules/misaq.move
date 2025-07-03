module 0x3bc02f2822b69f751105a9e6b31f0379ecf45e7e1164878522371d6d13496f40::misaq {
    struct MISAQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISAQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISAQ>(arg0, 9, b"MISAQ", b"misaq", b"{\"description\":\"misaq is finally here\",\"twitter\":\"https://twitter.com/misaq\",\"website\":\"\",\"telegram\":\"https://t.me/misaq\",\"tags\":[\"misaq\",\"crypto\"]}", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/ea712910-a6b5-4ad9-baec-62d01c44b411.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MISAQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISAQ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

