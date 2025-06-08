module 0xc11a2f7b7a9cf5a844231f9895fae6ecde8037537214b4f29538f20b5b9863a7::thetrench {
    struct THETRENCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: THETRENCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THETRENCH>(arg0, 6, b"TheTrench", b"Sui Trench", b"Sui Trench is a meme-driven project on the Sui blockchain, inspired by the enigmatic depths of the Mariana Trench, the deepest and most mysterious place on Earth. Just like the uncharted waters of the ocean, Sui Trench is a bold exploration into the world of decentralized fun, community engagement, and the untapped potential of meme culture on blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicxhu6kucr7za22cczr6ptsuznr5beysfjdynoisht3uzdjxyoenq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THETRENCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<THETRENCH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

