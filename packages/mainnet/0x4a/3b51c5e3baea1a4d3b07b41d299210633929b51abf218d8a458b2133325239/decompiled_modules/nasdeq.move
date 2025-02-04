module 0x4a3b51c5e3baea1a4d3b07b41d299210633929b51abf218d8a458b2133325239::nasdeq {
    struct NASDEQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NASDEQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NASDEQ>(arg0, 9, b"NASDEQ", b"Nasdeq", b"We're not just another meme coin we're a revolution disguised as a joke. While the suits on Wall Street play their games, we're building something different: a community of degens who understand that the real gains were the friends we made along the way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZaPk4sdtXt29MJWGgBVHCrfPvbWARozSboFeB7HH4itH")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NASDEQ>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NASDEQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NASDEQ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

