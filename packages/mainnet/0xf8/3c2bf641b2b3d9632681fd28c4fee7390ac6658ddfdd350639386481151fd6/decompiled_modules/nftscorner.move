module 0xf83c2bf641b2b3d9632681fd28c4fee7390ac6658ddfdd350639386481151fd6::nftscorner {
    struct NFTSCORNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFTSCORNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFTSCORNER>(arg0, 6, b"NFTsCorner", b"NFTs Corner", b"NFTs Corner is a community-driven meme coin designed to empower NFT enthusiasts and Web3 pioneers. By holding NFTs Corner tokens, you unlock access to future airdrops, exclusive projects, and rewards within our growing ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735968670063.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NFTSCORNER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFTSCORNER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

