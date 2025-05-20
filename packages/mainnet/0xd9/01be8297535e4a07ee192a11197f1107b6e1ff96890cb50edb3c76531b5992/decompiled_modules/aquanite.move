module 0xd901be8297535e4a07ee192a11197f1107b6e1ff96890cb50edb3c76531b5992::aquanite {
    struct AQUANITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUANITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUANITE>(arg0, 6, b"AQUANITE", b"Aquanite sui", b"The ultimate rug-free meme on SUI. The AQUANITE is here to dominate all memes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiab4x47f44jig6e2zqbagkvbpeivuhghw6k7eomrcs4dpwd4gvms4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUANITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AQUANITE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

