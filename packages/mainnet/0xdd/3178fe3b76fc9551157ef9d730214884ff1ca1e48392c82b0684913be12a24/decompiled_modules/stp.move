module 0xdd3178fe3b76fc9551157ef9d730214884ff1ca1e48392c82b0684913be12a24::stp {
    struct STP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STP>(arg0, 6, b"STP", b"STRIP", b"Where memes, crypto, and bad decisions collide.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000088629_131b0720f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STP>>(v1);
    }

    // decompiled from Move bytecode v6
}

