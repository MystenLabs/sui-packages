module 0x874eeaa98ef0e63c4574c5876c3b3e9af7d04b1db6a31d8afa03f114963a5cbd::rmonsui {
    struct RMONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMONSUI>(arg0, 6, b"RMONSUI", b"Renamon DIGIMON SUI", b"Renamon - a Digimon with a fox-like appearance inspired from a fox spirit from Mythical Asian history. He is here to smash with his palm strike and power paw.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicv6zp3b2ung6h3zivazvfjysi3pzbg4y4zwo4dnnnucnb2zokdse")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RMONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RMONSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

