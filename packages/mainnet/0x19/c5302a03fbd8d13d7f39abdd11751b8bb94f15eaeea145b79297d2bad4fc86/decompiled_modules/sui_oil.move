module 0x19c5302a03fbd8d13d7f39abdd11751b8bb94f15eaeea145b79297d2bad4fc86::sui_oil {
    struct SUI_OIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_OIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_OIL>(arg0, 6, b"SUI OIL", b"Sui OIL", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_OIL>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_OIL>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI_OIL>>(v2);
    }

    // decompiled from Move bytecode v6
}

