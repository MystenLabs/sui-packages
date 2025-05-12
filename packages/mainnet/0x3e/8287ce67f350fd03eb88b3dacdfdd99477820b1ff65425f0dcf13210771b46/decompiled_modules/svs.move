module 0x3e8287ce67f350fd03eb88b3dacdfdd99477820b1ff65425f0dcf13210771b46::svs {
    struct SVS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVS>(arg0, 6, b"SvS", b"Sui V Sol", b"The meme war we didnt know we needed. $SvS is the frontline in the ultimate battle of chains where Sui's diamond handed community faces off against Solana's keyboard cowboys.  Pick your side or get steamrolled.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifa7x45olmqv4ppbmmdm2em5a5dzcdsb5vls5gcavrrj2uzsjxmeu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SVS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

