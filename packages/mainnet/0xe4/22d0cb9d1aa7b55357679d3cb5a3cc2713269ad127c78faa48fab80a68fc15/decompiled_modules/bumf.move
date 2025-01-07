module 0xe422d0cb9d1aa7b55357679d3cb5a3cc2713269ad127c78faa48fab80a68fc15::bumf {
    struct BUMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMF>(arg0, 6, b"BUMF", b"Toilet Paper", b"Toilet paper is the greatest invention of mankind", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6uc05bgw1t1d2veuur6lfa0qkg0dx1bx_8f51aa91ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUMF>>(v1);
    }

    // decompiled from Move bytecode v6
}

