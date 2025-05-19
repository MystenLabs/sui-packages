module 0x5c105d7ddbeaa4a4a63e3fbb6efb59a2fcad2519daf934fbc48186198a6fe028::toge {
    struct TOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOGE>(arg0, 6, b"TOGE", b"TOGEPI", b"Meet Togepi  TOGE, the adorable Pokemon themed meme coin on the super fast Sui blockchain. This fairy egg brings fun, luck, and chaotic Metronome vibes to your crypto journey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigkqjnnx2h4mv2c3e26g42bon34py2tj5clz5rd6ne3qwhstdjrty")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

