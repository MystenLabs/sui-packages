module 0x39e2e474a1e45f4f39d370ba894bf76060717b53bd9bfb6f88bf2dcb75197530::grumpy {
    struct GRUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUMPY>(arg0, 6, b"GRUMPY", b"GRUMPY CAT", b"i'm so excited for this yuupy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xe38babf1e0f7e549f9d4c0441c9d00c8ffc9dcd34dcc19f3bb12eafe0267e037movepump_MOVEPUMP_3_c455274d60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRUMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

