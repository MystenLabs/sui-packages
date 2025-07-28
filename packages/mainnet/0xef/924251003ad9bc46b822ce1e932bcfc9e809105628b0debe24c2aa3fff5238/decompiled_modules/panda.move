module 0xef924251003ad9bc46b822ce1e932bcfc9e809105628b0debe24c2aa3fff5238::panda {
    struct PANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDA>(arg0, 6, b"PANDA", b"AGENT PANDA", b"Welcome to Agent Panda, a playful and unique meme coin on the Sui Blockchain, launched on Moonbags.io. Inspired by the gentle and goofy charm of panda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib6y4yalgw3zvcqpbtv2ng7g7ellx2xdu76hqrz4oyeev7xcdhra4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PANDA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

