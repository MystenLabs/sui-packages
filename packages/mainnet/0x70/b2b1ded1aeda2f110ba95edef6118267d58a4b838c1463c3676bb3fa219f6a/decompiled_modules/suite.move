module 0x70b2b1ded1aeda2f110ba95edef6118267d58a4b838c1463c3676bb3fa219f6a::suite {
    struct SUITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITE>(arg0, 6, b"SUITE", b"Sniper Suite", b"BEST SNIPER ON SUIT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021472_b0a71a7be8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

