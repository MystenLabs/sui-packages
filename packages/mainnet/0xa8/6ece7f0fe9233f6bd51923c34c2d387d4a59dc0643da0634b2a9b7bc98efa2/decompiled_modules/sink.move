module 0xa86ece7f0fe9233f6bd51923c34c2d387d4a59dc0643da0634b2a9b7bc98efa2::sink {
    struct SINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINK>(arg0, 6, b"SINK", b"SINK BOWL", b"Welcome to Sink Bowl the wackiest, splashiest meme project on the Sui blockchain Were here to drain the boring and overflow with laughs, vibes, and pure decentralized fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih4v422fya6vvq7k3jk2s2mff5sobze46hlqki7xtjndpb3chcule")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SINK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

