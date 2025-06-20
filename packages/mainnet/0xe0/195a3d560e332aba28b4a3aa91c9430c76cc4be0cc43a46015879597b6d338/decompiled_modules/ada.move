module 0xe0195a3d560e332aba28b4a3aa91c9430c76cc4be0cc43a46015879597b6d338::ada {
    struct ADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADA>(arg0, 8, b"ADA", b"Cardano", b"ZO Virtual Coin for Cardano", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ADA>>(v0);
    }

    // decompiled from Move bytecode v6
}

