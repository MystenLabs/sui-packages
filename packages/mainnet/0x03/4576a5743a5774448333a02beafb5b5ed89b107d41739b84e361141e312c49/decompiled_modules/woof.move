module 0x34576a5743a5774448333a02beafb5b5ed89b107d41739b84e361141e312c49::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 6, b"WOOF", b"Wooof", b"Woof is a community-driven meme token on the Sui blockchain that embraces the fun, chaotic energy of internet culture. Designed to be lighthearted yet rooted in the power of decentralized communities, Woof aims to bring humor, hype, and a bit of wild energy to the Sui ecosystem. No promises, no roadmaps just pure meme-fueled momentum.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia2yaptl3vmk4kddc35orl2x6fkmfnovzwldh4kkq7gqoci6a5f5m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOOF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

