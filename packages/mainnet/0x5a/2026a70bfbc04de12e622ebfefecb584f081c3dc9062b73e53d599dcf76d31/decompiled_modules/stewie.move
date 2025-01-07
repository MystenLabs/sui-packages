module 0x5a2026a70bfbc04de12e622ebfefecb584f081c3dc9062b73e53d599dcf76d31::stewie {
    struct STEWIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEWIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEWIE>(arg0, 6, b"STEWIE", b"Stewie", b"What would you do if a baby with world domination on his mind created his own cryptocurrency? Introducing $STEWIE: the coin that challenges not only the laws of the market but also the rules of responsible parenting. Join the revolution of diapers, sarcasm, and potential profitsbecause when Stewie rules the world, youll want a piece of his digital treasure!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_171a741ea0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEWIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEWIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

