module 0xfa25ba987409261fddcf0b9f6b4a2f33525b43582bfc140bad18d9a72cf6f665::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 6, b"AQUA", b"Aquatic", b"Aquatic is a memecoin project built on the Sui network, with a focus on community strength and organic growth potential. We do not offer false promises or complicated roadmaps just opportunities to grow together in the dynamic crypto ecosystem. Join us in creating new momentum in the world of memecoins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihtguyszn7ble4pauot2mnxuqlw2yd3ompesix6z2urz5s3oqjqme")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AQUA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

