module 0x657e528f65f02ca89df6627394e957296feb71a9e181dd212e4bba5c1da2a83e::kabosu {
    struct KABOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABOSU>(arg0, 6, b"KABOSU", b"Sui Kabosu Inu", x"466972737420244b41424f535520204f4e204d4f56452050554d500a68747470733a2f2f742e6d652f45544847656d5f63616c6c2f333834", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/kabosu_dfbbf1a071.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KABOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

