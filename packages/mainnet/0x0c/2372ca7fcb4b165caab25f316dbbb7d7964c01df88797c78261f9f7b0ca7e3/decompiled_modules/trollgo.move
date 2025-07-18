module 0xc2372ca7fcb4b165caab25f316dbbb7d7964c01df88797c78261f9f7b0ca7e3::trollgo {
    struct TROLLGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLLGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLLGO>(arg0, 6, b"TROLLGO", b"TROLL AND GO", x"57656c636f6d6520746f207468652044756d6265737420496e766573746d656e74206f6e2053554921210a4a7573742054524f4c4c20414e4420474f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihietasxvf7hwwuldmcstqbqtf6hvi5azmfx74vjg6ttvzzihtbs4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLLGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TROLLGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

