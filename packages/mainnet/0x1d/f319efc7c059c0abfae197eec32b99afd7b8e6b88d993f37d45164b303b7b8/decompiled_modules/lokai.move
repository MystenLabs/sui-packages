module 0x1df319efc7c059c0abfae197eec32b99afd7b8e6b88d993f37d45164b303b7b8::lokai {
    struct LOKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LOKAI>(arg0, 6, b"LOKAI", b"Lokai V2 by SuiAI", b"neuron to its brain! The more neurons it gains, the stronger and smarter its artificial intelligence becomes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_20250113_005121_103_858921db97.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOKAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOKAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

