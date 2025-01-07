module 0xb27355c472706b5f033b9c3925378cded25822ff94f829cf767d9b3cc2da1d87::jackolantern {
    struct JACKOLANTERN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACKOLANTERN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACKOLANTERN>(arg0, 6, b"JACKOLANTERN", b"Jack o Lantern", b"Lighting up the spooky side of Sui, this coin is your Halloween spirit in token form. Pumpkins, candles, and moonlit nights. Get ready for the scariest pump of the season!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jack_o_Lantern_5e0f8af533.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACKOLANTERN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACKOLANTERN>>(v1);
    }

    // decompiled from Move bytecode v6
}

