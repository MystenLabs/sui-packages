module 0x90c102eadb9e9a25f784b4e8c1cb8a8eb731883a0909731a3f9ee2f6643a414a::spy {
    struct SPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPY>(arg0, 6, b"SPY", b"SUIPAY", b"SuiPay ($SPY) is designed to be the backbone of payments and liquidity on Sui, offering a fixed-supply model that balances sustainability and utility. With integrations across DeFi, e-commerce, and Web3 finance, $SPY is positioned to become a core asset in the next-generation blockchain economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suipay_35575aa1c1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

