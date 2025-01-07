module 0x19d38871b3eea004810f967f0c64488105924876744f03cc4be93bed5c577d18::metamask {
    struct METAMASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: METAMASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METAMASK>(arg0, 6, b"MetaMask", b"MetaMask MEME", b"MetaMask is a fun and innovative meme cryptocurrency designed to attract the meme and digital currency community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_Ubgzfgg_400x400_0072e7e92e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METAMASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<METAMASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

