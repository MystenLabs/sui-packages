module 0xb892ed6bd6b809ce6e78349db8bf7dd135c256adcf55db1fa2ae30fcfabd5281::kewk {
    struct KEWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEWK>(arg0, 6, b"KEWK", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEWK>>(v1);
        0x2::coin::mint_and_transfer<KEWK>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEWK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

