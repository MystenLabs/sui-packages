module 0xc6ca828241ca71427d2354dfa3259a7ee65841a51d475ea621f596da4153186::torsy {
    struct TORSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORSY>(arg0, 6, b"TORSY", b"TORSY SUI", x"48656c6c6f20544f525359204c4f56455253206f66207468652046697273742050656e6775696e204d656d65636f696e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1712461453728_9b2d47e33a12381f6620324409b6f823_7128ae513d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

