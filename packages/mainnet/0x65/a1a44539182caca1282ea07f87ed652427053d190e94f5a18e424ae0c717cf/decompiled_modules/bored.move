module 0x65a1a44539182caca1282ea07f87ed652427053d190e94f5a18e424ae0c717cf::bored {
    struct BORED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORED>(arg0, 6, b"BORED", b"Bored Boyz v2", b"Bored Boyz is back. After a quick reset, we are back with a fresh look, full transparency, and the same relentless energy. This isn't just a meme its a movement. Welcome to bored boyz on Sui. For the culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifcoe2loqxr2kwbhxu2kwo6gk7librb2htwvqxynb2652o2fd7yhm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BORED>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

