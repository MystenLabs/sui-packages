module 0x8d48ef206a5ccaaaa8e792a19b5407d5a54cfbe98563a474e7dc0da41fada582::wkt {
    struct WKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WKT>(arg0, 6, b"WKT", b"WhiskerToken", b"WhiskerToken (WKT) is the ultimate community-driven token for cat lovers and crypto enthusiasts alike. Combining the playful spirit of our feline friends with the innovation of decentralized finance, PurrfectCoin brings joy, utility, and value to its holders. Designed to be fun while offering real-world use cases, PurrfectCoin empowers its community by ensuring everyone has a voice in its future. Its deflationary mechanism reduces supply with each transaction, making PURR a scarce and valuable asset. With plans for integration into NFT projects, DeFi platforms, and exclusive partnerships, PurrfectCoin is poised for long-term success. Join the movement and embrace a token thats as cute as it is powerfulbecause nothing says \"purrfection\" like holding PurrfectCoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whisker_Token_12033da857.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

