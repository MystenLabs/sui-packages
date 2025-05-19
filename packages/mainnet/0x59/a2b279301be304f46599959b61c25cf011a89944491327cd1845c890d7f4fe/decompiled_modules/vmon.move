module 0x59a2b279301be304f46599959b61c25cf011a89944491327cd1845c890d7f4fe::vmon {
    struct VMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: VMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VMON>(arg0, 6, b"VMON", b"VEEMON", b"Veemon is a utility and gamified token designed for use in metaverse ecosystems, NFT gaming, and decentralized social platforms.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidsvkfkeklx5bk5mztepau4stcfnzyufytcdsogyn6fdlxrtirzx4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

