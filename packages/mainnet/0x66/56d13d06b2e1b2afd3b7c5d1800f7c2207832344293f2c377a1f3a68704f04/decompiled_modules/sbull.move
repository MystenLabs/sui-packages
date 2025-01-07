module 0x6656d13d06b2e1b2afd3b7c5d1800f7c2207832344293f2c377a1f3a68704f04::sbull {
    struct SBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBULL>(arg0, 6, b"SBULL", b"SUI BULL", x"2442756c6c27697368206f6e2074686520537569204e6574776f726b20f09f92a7f09f9082", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730968955521.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBULL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

