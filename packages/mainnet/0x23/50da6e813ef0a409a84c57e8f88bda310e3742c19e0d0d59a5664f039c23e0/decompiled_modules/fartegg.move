module 0x2350da6e813ef0a409a84c57e8f88bda310e3742c19e0d0d59a5664f039c23e0::fartegg {
    struct FARTEGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTEGG>(arg0, 6, b"FARTEGG", b"Fart Egg Memes", b"$FARTEGG - Fart Egg Memes , the stinky yet hilarious memecoin ! A quirky egg with green farts and goofy vibes, ready to blow up ! Jump in for the LOLs . Fart your way to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042146_91c9571622.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTEGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTEGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

