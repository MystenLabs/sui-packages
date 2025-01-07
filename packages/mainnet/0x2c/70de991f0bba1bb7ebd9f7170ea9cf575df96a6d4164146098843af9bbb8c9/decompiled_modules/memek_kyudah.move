module 0x2c70de991f0bba1bb7ebd9f7170ea9cf575df96a6d4164146098843af9bbb8c9::memek_kyudah {
    struct MEMEK_KYUDAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_KYUDAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_KYUDAH>(arg0, 6, b"MEMEKKYUDAH", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_KYUDAH>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_KYUDAH>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_KYUDAH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

