module 0x7107c3ab56268e140a27bfdf2015d60790175826f87bef3359e6d02fe03680ae::suigandese {
    struct SUIGANDESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGANDESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGANDESE>(arg0, 6, b"SUIGANDESE", b"Suigandese Nutz", x"5768617427732053756967616e646573653f2e2e2e0a0a53554947414e44455345204e55545a2120474f542027454d4d4d4d4d4d4d4d4d2e0a0a4d722053756967616e64657365204e75747a20706c616e7320746f206f6e626f617264206d696c6c696f6e7320746f20535549206279206d616b696e67207468656d2073756967616e64657365206e75747a2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mr_Sui_Peanut_in_Suit_4e5c957af0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGANDESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGANDESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

