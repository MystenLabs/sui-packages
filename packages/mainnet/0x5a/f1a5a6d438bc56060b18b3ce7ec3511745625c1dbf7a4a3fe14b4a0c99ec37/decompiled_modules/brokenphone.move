module 0x5af1a5a6d438bc56060b18b3ce7ec3511745625c1dbf7a4a3fe14b4a0c99ec37::brokenphone {
    struct BROKENPHONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROKENPHONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROKENPHONE>(arg0, 6, b"BrokenPhone", b"Broken Phone", x"6a75737420612042726f6b656e2050686f6e65206f6e207375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ee721b1e_ad92_4410_9888_f79c9c4bcab1_a9cb2a2375.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROKENPHONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROKENPHONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

