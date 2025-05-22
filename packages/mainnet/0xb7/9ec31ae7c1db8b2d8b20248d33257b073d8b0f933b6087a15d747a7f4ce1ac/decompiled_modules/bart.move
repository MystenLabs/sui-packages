module 0xb79ec31ae7c1db8b2d8b20248d33257b073d8b0f933b6087a15d747a7f4ce1ac::bart {
    struct BART has drop {
        dummy_field: bool,
    }

    fun init(arg0: BART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BART>(arg0, 6, b"BART", b"SUPER BART", b"SUPER BRAT is more than just a meme token, it's a community-driven cryptocurrency designed to bring fun and innovation to the Sui Chain. We aim to create a vibrant ecosystem where every holder can benefit from our unique approach to blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicm6odtsuwod3zqrftjlnxbsvb7e4isogpbdwfhfzopgvhqxiqzxm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BART>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

