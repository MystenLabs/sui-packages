module 0x656f2219e41a69447415cc276fb3bf8a8f5b9f1d9e3eed656fd7df7df435fc49::tarzan {
    struct TARZAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARZAN>(arg0, 6, b"TARZAN", b"Tarzan on Sui", b"Blue $TARZAN, born from Tarzan cartoons, swings with meme magic on Sui fun, wild, and ready to rule the crypto jungle!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicsnmzeaf7krlg6jye27jgkcm3d7azx34q3fogtlviggwgfk5byle")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARZAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TARZAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

