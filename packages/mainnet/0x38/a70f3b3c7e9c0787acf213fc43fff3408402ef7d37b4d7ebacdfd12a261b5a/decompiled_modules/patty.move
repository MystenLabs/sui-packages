module 0x38a70f3b3c7e9c0787acf213fc43fff3408402ef7d37b4d7ebacdfd12a261b5a::patty {
    struct PATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATTY>(arg0, 6, b"Patty", b"Krabby Patty", b"beloved underwater icon, Krabby patty!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif62mkdipb2h3w7hxegdf7anqszh6cbgmakfk6nnc7lpqgvcj43li")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PATTY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

