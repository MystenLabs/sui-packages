module 0xbeccb0e3080d0bcaf9035d7c055f7c531cccf8b61f93e69511d77bb77b8c84e4::malno {
    struct MALNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MALNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MALNO>(arg0, 6, b"MALNO", b"MALNO THE DOG", b"the internet's latest doggo obsession on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigesuphouswnikgi65ag2p5htt34oumrqzkqlwnzsjzp67bod7ngi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MALNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MALNO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

