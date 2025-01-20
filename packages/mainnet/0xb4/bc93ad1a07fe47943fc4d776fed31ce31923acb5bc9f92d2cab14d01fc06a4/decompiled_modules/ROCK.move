module 0xb4bc93ad1a07fe47943fc4d776fed31ce31923acb5bc9f92d2cab14d01fc06a4::ROCK {
    struct ROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCK>(arg0, 6, b"ROCK", b"Rockee AI", b"The AI-Driven DeFi Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://rockee.ai/images/logo.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

