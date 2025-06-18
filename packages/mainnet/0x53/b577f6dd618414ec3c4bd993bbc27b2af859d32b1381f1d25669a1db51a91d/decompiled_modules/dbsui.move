module 0x53b577f6dd618414ec3c4bd993bbc27b2af859d32b1381f1d25669a1db51a91d::dbsui {
    struct DBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBSUI>(arg0, 6, b"DBSUI", b"DragonBallZonSui", x"46726f6d20447261676f6e20576f726c6420746f2074686520426c6f636b636861696e2c20447261676f6e62616c6c5a6f6e537569206973206272696e67696e6720737472656e67746820616e642073757065726e617475616c206162696c697469657320746f206d656d652063756c747572650a204974277320447261676f6e2054696d6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiavo2mhenfwtx5knpxyj7r7k7wrujppupbkqlhneou3poeii5x37y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DBSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

