module 0x224bbf7637141ae6e82ca416cebb23298f502457b9b3c7bb2b9c98d640eee17d::ocean {
    struct OCEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<OCEAN>(arg0, 11151608752892918166, b"Blub Ocean", b"OCEAN", b"Fish need a place to swim", b"https://images.hop.ag/ipfs/QmNQMfrPvTXJEG2arT7G9MzCMq5zYj1v47JRUqZCNDhMdQ", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

