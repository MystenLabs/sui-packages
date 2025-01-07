module 0xd4e5776743c75532181ba7acda8d968f95acca2fcb9a599dd64d09750f5e4e7d::suimace {
    struct SUIMACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMACE>(arg0, 6, b"SUIMACE", b"GRIMACE SUI", b"Grimace on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3811_1b2442cbf3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

