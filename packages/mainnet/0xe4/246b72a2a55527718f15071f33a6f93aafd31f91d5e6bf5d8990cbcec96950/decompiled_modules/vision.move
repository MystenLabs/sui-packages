module 0xe4246b72a2a55527718f15071f33a6f93aafd31f91d5e6bf5d8990cbcec96950::vision {
    struct VISION has drop {
        dummy_field: bool,
    }

    fun init(arg0: VISION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VISION>(arg0, 6, b"VISION", b"SUI VISION", b"SUI VISION is a meme token inspired by the Sui blockchain, built to unite a community around humor, creativity, and a shared vision for the future of Web3. It embraces the culture of internet memes while providing a space for community-driven engagement. SUI VISION does not aim to deliver utility or financial promises, but instead thrives on social momentum, trends, and the power of collective imagination in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie2bx7uubwo2uwj54a4sdjor74sj4ricr4nd2zazsrufpa375sfne")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VISION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VISION>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

