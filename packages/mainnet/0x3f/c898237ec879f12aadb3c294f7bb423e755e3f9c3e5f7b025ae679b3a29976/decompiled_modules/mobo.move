module 0x3fc898237ec879f12aadb3c294f7bb423e755e3f9c3e5f7b025ae679b3a29976::mobo {
    struct MOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBO>(arg0, 6, b"MOBO", b"Sui Mobo", b"For the first time in history meme save the planet, Unleash the mobo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig7dc2dcwnkhyxy43y4ukrf26drbsfiofgorokurfpikpjgclxday")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOBO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

