module 0x9662c38772752eae889940b1366f3ff2c3d22163c01b802951c9bc00765b6182::trap {
    struct TRAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAP>(arg0, 9, b"TRAP", b"DONALD TRAP", b"100% lp burned. i'm your robin hood", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRAP>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

