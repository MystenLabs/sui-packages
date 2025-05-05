module 0x8b93c2d5e9c97e88a6fbfd048a27d8740ac25dc8d8f02eb7c157b333b2d15d26::suilly {
    struct SUILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILLY>(arg0, 6, b"SUILLY", b"Shrimp Sully", b"Sully the Shrimp is a playful and vibrant memecoin built on the SUI blockchain, celebrating community and fun. Inspired by the spirit of friendship and light-heartedness, Sully aims to create an engaging ecosystem where users can share memes, participate in community events, and contribute to charitable causes. With fast transactions and low fees on the SUI blockchain, Sully provides a seamless experience for trading and holding. Join the Sully community, where every transaction brings a smile, and let's ride the wave of creativity together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibg4nlork7hvip3x33lewnq7nwbkgfxeoc43jdfvmr3h7m746va4u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

