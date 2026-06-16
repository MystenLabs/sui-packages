module 0x174995a264fa271344d056ec6d3c84b92db1fecda50a4ad49905c4365f7a5186::hLBTC {
    struct HLBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLBTC>(arg0, 8, b"hLBTC", b"hLBTC Coin", b"hLBTC Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://curator-liquidity-mainnet.haedal.xyz/coin-icons/hlbtc_ddb273741a_13554.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

