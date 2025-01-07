module 0xda79c0756319ea12c1679cb0d2c9fa85c66c0c724f45b7d1af0f7ed79fe4573d::suiz {
    struct SUIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZ>(arg0, 6, b"SUIZ", b"SUIZ", b"Suizzle Proof of Work Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

