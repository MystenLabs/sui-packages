module 0xd978e1d1a08cc1ce99a26474d5e06a43a346bec365e698cb8d6af973953902b3::pol {
    struct POL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POL>(arg0, 6, b"POL", b"POLIWAG", b"working on something I think you'd vibe with it's called POLIWAG a Character in Pokemon Water Type. this project blending chaos, strategy, and a bit of absurdity into the Sui Memes world. Would love to share more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidaeagz2kpdt26z67cnakcge53najex5w5p45bzlmxokrzxtxcwmy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

