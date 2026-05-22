module 0x90348093311e90790fd766c1e1e7522f74e520ea256a5cdf2a1b918b87cbbe41::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 9, b"PEPE", b"PEPE", b"ZO Virtual Coin for PEPE", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPE>>(v0);
    }

    // decompiled from Move bytecode v7
}

