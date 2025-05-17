module 0xbe8edbf38926d97c1f6f3e48c44ef70364784685423b495ba31166b7228b74fd::spy {
    struct SPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPY>(arg0, 6, b"SPY", b"Suipay", b"SuiPay ($SPY) is designed to be the backbone of payments and liquidity on Sui, offering a fixed-supply model that balances sustainability and utility. With integrations across DeFi, e-commerce, and Web3 finance, $SPY is positioned to become a core asset in the next-generation blockchain economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihbw7dlsds3on2kiq2ewyr6yiwccueasuql2cu42xzeuaga3xbnsu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

