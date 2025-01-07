module 0xc2e0fb3da246ecdb7949f3ff4c76fdf177066ceff3508fcd4d86297dfb4d8228::tax {
    struct TAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAX>(arg0, 6, b"TAX", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

