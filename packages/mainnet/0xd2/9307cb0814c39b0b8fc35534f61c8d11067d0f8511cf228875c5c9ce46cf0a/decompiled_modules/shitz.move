module 0xd29307cb0814c39b0b8fc35534f61c8d11067d0f8511cf228875c5c9ce46cf0a::shitz {
    struct SHITZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITZ>(arg0, 6, b"SHITZ", b"Lil' Shitz on Sui", b"Lil' Shitz isn't your ordinary NFT project on SUI! The collection is being developed as collectible pfp's that are playable in a strategic trading card game. IRL cards will be awarded to \"Og\" minted NFTs. Art is inspired by WILD kids. Stay t00ned!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicqi72qlo5lr4kv7i3sc3vrrdfqhuknh3ltfyiely6wyhqq24bzei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHITZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

