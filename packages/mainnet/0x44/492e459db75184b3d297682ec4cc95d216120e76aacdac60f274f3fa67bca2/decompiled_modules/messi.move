module 0x44492e459db75184b3d297682ec4cc95d216120e76aacdac60f274f3fa67bca2::messi {
    struct MESSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESSI>(arg0, 6, b"MESSI", b"Lionel Messi", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MESSI>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MESSI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MESSI>>(v2);
    }

    // decompiled from Move bytecode v6
}

