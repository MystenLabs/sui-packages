module 0x77c8f02a441ff2a1ccafb83125205614b5a7dcee688906ce425215b94f7712b8::stbtc {
    struct STBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STBTC>(arg0, 9, b"stBTC", b"Lorenzo Protocol", b"To be the premier Bitcoin platform for yield-bearing token issuance, trading, and settlement. Lorenzo is the Bitcoin Liquidity Finance Layer. With the global adoption of Bitcoin growing, there is a significantly higher demand for Bitcoin liquidity, by ways of L2s, DeFi, trading, etc., and platforms are promising yield in exchange for Bitcoin liquidity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/Lorenzo_st_BTC_01d18aebd3.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<STBTC>>(0x2::coin::mint<STBTC>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STBTC>>(v2);
    }

    // decompiled from Move bytecode v6
}

