module 0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin {
    struct KAMISAYAKA_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMISAYAKA_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMISAYAKA_COIN>(arg0, 8, b"KAMISAYAKA_COIN", b"kamisayaka_coin", b"my first move coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.app.goo.gl/54GNKMSAurz1vbH77")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMISAYAKA_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMISAYAKA_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

