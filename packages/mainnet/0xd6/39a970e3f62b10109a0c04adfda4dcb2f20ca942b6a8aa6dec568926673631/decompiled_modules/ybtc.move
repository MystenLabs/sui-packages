module 0xd639a970e3f62b10109a0c04adfda4dcb2f20ca942b6a8aa6dec568926673631::ybtc {
    struct YBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: YBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YBTC>(arg0, 8, b"YBTC.B", b"Yield BTC.B", b"YBTC.B is a wrapped version of Bitlayer's Native BTC, enabling seamless cross-chain liquidity for DeFi across EVM and non-EVM chains", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

