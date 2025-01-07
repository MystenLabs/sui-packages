module 0x69ce2c5522ab27338a2525f6d451b60fc185e9fb3a5f1aba76ae6a884ddf404e::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 0, b"PEPE", b"Wrapped Pepe", b"ABEx Virtual Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPE>>(v0);
    }

    // decompiled from Move bytecode v6
}

