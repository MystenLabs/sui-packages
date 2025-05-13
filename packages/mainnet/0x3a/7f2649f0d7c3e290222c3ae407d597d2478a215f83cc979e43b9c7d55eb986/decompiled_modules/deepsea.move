module 0x3a7f2649f0d7c3e290222c3ae407d597d2478a215f83cc979e43b9c7d55eb986::deepsea {
    struct DEEPSEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPSEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPSEA>(arg0, 6, b"DEEPSEA", b"CHALLENGER DEEP", b"Dive into the uncharted waters of the Sui Blockchain with Under The Sui Sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiay2j5jhf6o4cqacqvz5dyadhfgt34og62ig4jdodqnzwf2v5jzuu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPSEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEEPSEA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

