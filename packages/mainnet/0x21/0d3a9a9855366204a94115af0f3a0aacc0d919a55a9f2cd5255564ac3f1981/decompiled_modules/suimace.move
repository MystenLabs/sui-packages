module 0x210d3a9a9855366204a94115af0f3a0aacc0d919a55a9f2cd5255564ac3f1981::suimace {
    struct SUIMACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMACE>(arg0, 6, b"SUIMACE", b"GRIMACE ON SUI", b"GRIMACE BACK ON SUI $SUIMACE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3596_f4b3b1c0ac.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

