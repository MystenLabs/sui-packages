module 0x9fca52d98e7ff59d45f2063e42d2b6062b4d5701c79db77da88c97e4fb1942de::tonyfucker {
    struct TONYFUCKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONYFUCKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONYFUCKER>(arg0, 6, b"TONYFUCKER", b"TONYFUCKER", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONYFUCKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TONYFUCKER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

