module 0xf203dbfaf9822f176e5c1d1b7b199383fa77552a37c33a3e3863b19ec76bedd3::lit {
    struct LIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIT>(arg0, 6, b"LIT", b"LIT - A Burned Meme moving Through SUI", b"$LIT is a burned Entity born from the fire of the blockchain. The brother of Wet. A flare. A movement. Burning through Sui, rare, untamed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiec2uynppnnreuibs2yql4cnv3sba3r47au6xolu3lxvfnhthol7m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LIT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

