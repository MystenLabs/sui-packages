module 0x2e88b2ece262201276b02c0505d958987c29196e9c23828b11eac7bb561a6c92::uh96ofz {
    struct UH96OFZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: UH96OFZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UH96OFZ>(arg0, 0, b"UH96OFZ", b"Sui Blue Gift User H96OFZ", b"Sui Blue Gift mainnet user-flow smoke token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UH96OFZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UH96OFZ>>(0x2::coin::mint<UH96OFZ>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UH96OFZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

