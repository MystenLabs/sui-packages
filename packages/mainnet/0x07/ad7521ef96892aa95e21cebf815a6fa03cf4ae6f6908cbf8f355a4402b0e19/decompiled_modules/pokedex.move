module 0x7ad7521ef96892aa95e21cebf815a6fa03cf4ae6f6908cbf8f355a4402b0e19::pokedex {
    struct POKEDEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEDEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEDEX>(arg0, 6, b"POKEDEX", b"Pokedex On Sui", b"Welcome to Pokedex Tracker Pokedex Tracker is a cutting-edge platform built on the Sui blockchain, designed to help Pokmon enthusiasts track and catalog their NFT collections with a retro, pixelated aesthetic inspired by classic Pokmon games.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic6vnp6lznporbvrpig7ktkhavqam23ikqy6nnzlnut6s6cwcokoa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEDEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEDEX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

