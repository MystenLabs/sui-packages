module 0xa38eb0a9a3c066210ed80ff1370cae18de1df632c245cc7c44ba7731af7c1990::drip {
    struct DRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIP>(arg0, 6, b"DRIP", b"Drip on Sui-chain", b"Drip is a next-gen token built on the Sui blockchain, optimized for fast, secure microtransactions, NFT, and community-driven experiences in a scalable, decentralized ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicx3a773vm6vbqbpehpxi6thfduhbwv3uf7j5sqdsu5k43xhqaguu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRIP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

