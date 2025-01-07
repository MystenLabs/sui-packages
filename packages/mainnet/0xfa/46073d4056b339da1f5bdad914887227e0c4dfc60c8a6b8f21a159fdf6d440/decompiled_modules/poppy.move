module 0xfa46073d4056b339da1f5bdad914887227e0c4dfc60c8a6b8f21a159fdf6d440::poppy {
    struct POPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPPY>(arg0, 9, b"POPPY", b"Poppy", b"Poppy is a simple, vibrant token name that conveys energy, growth, and an approachable vibe, perfect for a fresh and impactful digital currency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1786042367356579841/Hl1LRNxH.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPPY>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPPY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

