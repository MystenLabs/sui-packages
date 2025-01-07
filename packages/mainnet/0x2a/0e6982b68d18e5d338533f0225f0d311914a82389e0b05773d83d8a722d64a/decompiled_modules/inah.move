module 0x2a0e6982b68d18e5d338533f0225f0d311914a82389e0b05773d83d8a722d64a::inah {
    struct INAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: INAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INAH>(arg0, 6, b"INAH", b"SPLO Artist", b"Who is Inah? Inah is the artist behind $SPLO art & design. After $SPLO developer was rugged, Inah took over the community since he gained access to the website, Twitter, and Telegram.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tickerinah_f39e8e0e3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

