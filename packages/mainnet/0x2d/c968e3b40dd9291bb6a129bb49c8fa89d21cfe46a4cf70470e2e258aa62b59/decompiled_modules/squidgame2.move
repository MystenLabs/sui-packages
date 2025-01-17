module 0x2dc968e3b40dd9291bb6a129bb49c8fa89d21cfe46a4cf70470e2e258aa62b59::squidgame2 {
    struct SQUIDGAME2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDGAME2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDGAME2>(arg0, 6, b"SQUIDGAME2", b"Squid Game 2 - NETFLIX", b"We will use the SUI network, to take the next step. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250117_193016_412_5cc7efe809.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDGAME2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDGAME2>>(v1);
    }

    // decompiled from Move bytecode v6
}

