module 0x5abe7c241391172579802d4203bf5622ae1fa02b9f5605a5f55d931ef2a7db60::sporting_cp_1793610042924_no {
    struct SPORTING_CP_1793610042924_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPORTING_CP_1793610042924_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPORTING_CP_1793610042924_NO>(arg0, 0, b"SPORTING_CP_1793610042924_NO", b"SPORTING_CP_1793610042924 NO", b"SPORTING_CP_1793610042924 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPORTING_CP_1793610042924_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPORTING_CP_1793610042924_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

