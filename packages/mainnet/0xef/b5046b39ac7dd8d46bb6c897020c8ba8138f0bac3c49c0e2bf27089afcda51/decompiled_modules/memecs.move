module 0xefb5046b39ac7dd8d46bb6c897020c8ba8138f0bac3c49c0e2bf27089afcda51::memecs {
    struct MEMECS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECS>(arg0, 6, b"MEMECS", b"Memecoin Studio", b"The ultimate AI-powered launchpad for creating and deploying memecoins across multiple blockchains. Start with Solana, with other networks coming soon. Your vision, our tech. Let's make it legendary.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidlgivpmc2pa7xgazgv447qkmbg7vpmminyrmqnhgkhxcwswj4pkq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEMECS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

