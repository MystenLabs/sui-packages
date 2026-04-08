module 0x912830760b720713a4bc220d622cbe3ec6167d3d00a4c58ed7b820c34864c769::bluai {
    struct BLUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUAI>(arg0, 6, b"BLUAI", b"BluWhaleAI", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUAI>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUAI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLUAI>>(v2);
    }

    // decompiled from Move bytecode v6
}

