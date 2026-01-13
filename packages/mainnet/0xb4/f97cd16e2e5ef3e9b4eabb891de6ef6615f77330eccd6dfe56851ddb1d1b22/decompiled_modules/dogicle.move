module 0xb4f97cd16e2e5ef3e9b4eabb891de6ef6615f77330eccd6dfe56851ddb1d1b22::dogicle {
    struct DOGICLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGICLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGICLE>(arg0, 6, b"DOGICLE", b"dogicle", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGICLE>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGICLE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGICLE>>(v2);
    }

    // decompiled from Move bytecode v6
}

