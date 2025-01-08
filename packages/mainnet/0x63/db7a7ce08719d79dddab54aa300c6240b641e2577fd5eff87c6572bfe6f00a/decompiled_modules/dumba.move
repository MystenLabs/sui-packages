module 0x63db7a7ce08719d79dddab54aa300c6240b641e2577fd5eff87c6572bfe6f00a::dumba {
    struct DUMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMBA>(arg0, 6, b"DUMBA", b"DUMB AGENT", b"Just a Dumb Agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bot_profile_3fdd7a6a26.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

