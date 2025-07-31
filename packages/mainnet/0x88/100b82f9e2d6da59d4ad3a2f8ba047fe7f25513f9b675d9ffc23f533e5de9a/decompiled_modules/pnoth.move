module 0x88100b82f9e2d6da59d4ad3a2f8ba047fe7f25513f9b675d9ffc23f533e5de9a::pnoth {
    struct PNOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNOTH>(arg0, 6, b"Pnoth", b"PNothing", b"I'm nothing just pure meme vibes,no rug enjoyed the ride ! WAGMI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidjgma6igpv6wwt7nvsc3pzakje53fdttwkvhcji7t75xtrbdt6yq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PNOTH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

