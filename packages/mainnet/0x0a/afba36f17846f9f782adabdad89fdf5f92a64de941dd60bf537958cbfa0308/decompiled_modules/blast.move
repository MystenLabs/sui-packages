module 0xaafba36f17846f9f782adabdad89fdf5f92a64de941dd60bf537958cbfa0308::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAST>(arg0, 6, b"Blast", b"Blastmon", b"$BLASTMON is a meme-driven token on the Sui blockchain that merges strong visual branding with community features like Telegram battles, staking, and NFT evolution. It launches with zero tax, burned liquidity, and a 70 percent public allocation, ensuring fair distribution and long-term growth potential. Blast is not just a mascot  it's the core of a digital movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifecrrycyu5lxp3nklovic6jaireoqjjef7i5oupyr6jzr65dg6qi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLAST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

