module 0xa8c5b80b1cfe5feb51be4f6d61ed1e4694c4383a0988eb326d1b6f07ea58e2fd::lbtc {
    struct LBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LBTC>(arg0, 8, b"LBTC", b"Lombard Staked BTC", b"Lombard connects Bitcoin to DeFi through LBTC, the Universal Liquid Bitcoin Standard. Backed 1:1 by BTC, LBTC is yield-bearing, cross-chain, and enables BTC holders to earn Babylon staking yields, trade, borrow, lend, and yield farm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.lombard.finance/lbtc/LBTC.png"))), true, arg1);
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<LBTC>>(0x2::coin::mint<LBTC>(&mut v3, 1000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBTC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LBTC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LBTC>>(v2);
    }

    // decompiled from Move bytecode v7
}

