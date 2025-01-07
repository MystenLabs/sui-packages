module 0x7277d3622a66019c6498890ad908109e20341d4481519f0457601dc586108658::z3nai {
    struct Z3NAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: Z3NAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Z3NAI>(arg0, 6, b"Z3NAI", b"Zen AI", b"Master your trades with AI. Find your Zen, stay balanced, and optimize results.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736266959983.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Z3NAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Z3NAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

