module 0x3f0e7235b4a7c3f465a80a38b749d0ac5fa5d1f0cb00e00af00590e706ef96dd::www {
    struct WWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWW>(arg0, 6, b"WWW", b"Worldwide Walrus Coin", b"A meme coin with real-world utility. WWW is built to highlight Walrus Protocols NFT compatibility  making decentralized storage fun, viral, and accessible.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidb5hligxhg4lxfo5ipy2ylvgzedum4gu7b5i2ntal5jjlac2anei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WWW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

