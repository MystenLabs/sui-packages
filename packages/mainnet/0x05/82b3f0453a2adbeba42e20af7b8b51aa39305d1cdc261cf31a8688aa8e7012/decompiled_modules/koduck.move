module 0x582b3f0453a2adbeba42e20af7b8b51aa39305d1cdc261cf31a8688aa8e7012::koduck {
    struct KODUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KODUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KODUCK>(arg0, 6, b"Koduck", b"Koduck On Sui", b"Koduck is a memecoin inspired by Pokmons Psyduck, bringing the unique energy of the Sui Network. Combining the power of memes and the fun of the Pokmon universe, Koduck is the coin you dont need to understand, but will love to have!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaq2lkquxdeolnoqzzwsng3p3wfy6byqiatnrze7qeqlkrmuwv5l4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KODUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KODUCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

