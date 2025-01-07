module 0x49dbdc14c72f5c69bf970eedcdef145b885e60cc1d6aa08d55c6ddee4ebeae73::bencheckit {
    struct BENCHECKIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENCHECKIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENCHECKIT>(arg0, 6, b"BENCHECKIT", b"Ben Checks It", b"analyze the token for security and attractiveness and tell you whether it is worth the investment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2536_5b9256f7b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENCHECKIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENCHECKIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

