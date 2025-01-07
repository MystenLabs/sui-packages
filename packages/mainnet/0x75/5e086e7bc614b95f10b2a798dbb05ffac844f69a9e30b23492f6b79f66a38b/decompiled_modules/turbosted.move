module 0x755e086e7bc614b95f10b2a798dbb05ffac844f69a9e30b23492f6b79f66a38b::turbosted {
    struct TURBOSTED has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOSTED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOSTED>(arg0, 6, b"TURBOSTED", b"TURBOS TED", x"546564205368616f206974e280997320436f2d466f756e64657220262043454f20547572626f732046696e616e636520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730990700279.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOSTED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOSTED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

