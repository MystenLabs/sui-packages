module 0xa9bb641ba54ba2f49b4821f1bac4225eeb1f6d41130ef1e0ef43762c7ac08b1a::luckycat {
    struct LUCKYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCKYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCKYCAT>(arg0, 6, b"LUCKYCAT", b"LUCKY CAT", b"If you buy this coin you will have 100 years of good luck and you will get x10000 in your crypto portfolio.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/st1_9c1e46f69b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCKYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCKYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

