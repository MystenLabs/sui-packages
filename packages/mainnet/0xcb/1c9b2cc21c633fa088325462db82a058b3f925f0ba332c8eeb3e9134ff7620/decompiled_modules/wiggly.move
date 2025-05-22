module 0xcb1c9b2cc21c633fa088325462db82a058b3f925f0ba332c8eeb3e9134ff7620::wiggly {
    struct WIGGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIGGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIGGLY>(arg0, 6, b"WIGGLY", b"Pokemon Wiggly", b"Pokemon Wiggly is a project on the Sui blockchain, set to launch on Moonbags.io. Inspired by the iconic Wigglytuff character from the Pokemon universe, known for its charming, pink, puffball appearance and playful nature, the project aims to blend nostalgia with innovative blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie4jlbi6tfe6hj7fndnc2hrro3vhc467nylwwikgvgehyopzh27lu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIGGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WIGGLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

