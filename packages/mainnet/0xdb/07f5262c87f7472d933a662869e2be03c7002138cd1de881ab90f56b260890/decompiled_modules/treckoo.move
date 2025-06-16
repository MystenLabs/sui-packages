module 0xdb07f5262c87f7472d933a662869e2be03c7002138cd1de881ab90f56b260890::treckoo {
    struct TRECKOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRECKOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRECKOO>(arg0, 6, b"Treckoo", b"Pokemon Treckoo", b"Embark on a wild adventure with Pokemon Treckoo, the ultimate meme coin on the Sui blockchain Inspired by the iconic Pokemon universe, TRECKOO brings vibrant community spirit, epic vibes, and moonbound energy to Moonbags.io. Join our pack, hodl tight, and let Treckoo spark your crypto journey with fun and fortune", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicue36ctzqchtkvorkbbvqyl6lzahi6a4zbfunk3kuvphe2wlajvu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRECKOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRECKOO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

