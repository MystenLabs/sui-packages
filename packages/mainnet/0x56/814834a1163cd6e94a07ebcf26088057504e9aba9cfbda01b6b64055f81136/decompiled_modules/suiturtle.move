module 0x56814834a1163cd6e94a07ebcf26088057504e9aba9cfbda01b6b64055f81136::suiturtle {
    struct SUITURTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITURTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITURTLE>(arg0, 6, b"SUITURTLE", b"SUI TURTLE", b"Sui Turtle - Driven by AI & a budget of 420 usd.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_turtle_pfp_d6b27c2feb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITURTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITURTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

