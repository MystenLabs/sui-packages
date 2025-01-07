module 0x4b35198b55204cf94c9e24eb0d8f2e3874588a1ec510d52e07e95b2449f2381c::bathord {
    struct BATHORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATHORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATHORD>(arg0, 9, b"BATHORD", b"Bathord Coin", b"The author's coin of bathord_", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<BATHORD>(&mut v2, 100000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATHORD>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATHORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

