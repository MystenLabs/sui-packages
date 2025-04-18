module 0x1782e5627469d6506e576f91a77103860dfa9eaaebe0faaf2b48c5fda309f219::kraken {
    struct KRAKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAKEN>(arg0, 6, b"KRAKEN", b"Kraken", b"The beast of the meme coin sea! Unleash the Kraken and dive into the wildest, most entertaining crypto out there. Built for fun, powered by the community, and ready to make waves. Join the crew before the Kraken takes over!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/octopus_282d76351d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRAKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

