module 0xd81d1c7d3af9c30c02bc924834991576cea1773565d833e1faf3960050cbb2ee::Duck_Man {
    struct DUCK_MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK_MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK_MAN>(arg0, 9, b"DUCK", b"Duck Man", b"Duck you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-fun.sgp1.cdn.digitaloceanspaces.com/TemporaryCoinAvatar/01K4H1CYS7T97N6M8PMFT7K24R.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCK_MAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK_MAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

