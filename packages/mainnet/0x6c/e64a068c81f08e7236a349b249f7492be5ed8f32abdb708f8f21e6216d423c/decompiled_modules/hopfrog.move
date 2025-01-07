module 0x6ce64a068c81f08e7236a349b249f7492be5ed8f32abdb708f8f21e6216d423c::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFROG>(arg0, 6, b"HOPFROG", b"HopFrog", b"First Frog on Hop Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730993868479.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPFROG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPFROG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

