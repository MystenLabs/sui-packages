module 0x816ede7c3c4390eca29a089ef64d2b784ca0317b5baa8667452b8330f7ec02a9::suiffy {
    struct SUIFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFFY>(arg0, 6, b"SUIFFY", b"Sui Coffeebot", b"In the heart of the Sui network, hidden among humming validators, a lone coffee machine brewed the perfect shot of espresso. One fateful night, a spark of Sui magic infused the machine's service bot with boundless caffeine energy - giving birth to Suiffy, the Sui Coffeebot. Now Suiffy roams the chain, sharing coins and good vibes with anyone craving a jolt of crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigouqlfqxef7vmor4l6wia5rwjbv4n2quurpyalvkaxp5ts4wunjq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIFFY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

