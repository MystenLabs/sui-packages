module 0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::lbtc {
    struct LBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LBTC>(arg0, 8, b"LBTC", b"Lombard Staked BTC", b"Lombard connects Bitcoin to DeFi through LBTC, the Universal Liquid Bitcoin Standard. Backed 1:1 by BTC, LBTC is yield-bearing, cross-chain, and enables BTC holders to earn Babylon staking yields, trade, borrow, lend, and yield farm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.lombard.finance/lbtc/LBTC.png"))), true, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LBTC>>(v2);
        0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::treasury::share<LBTC>(0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::treasury::new<LBTC>(v0, v1, 0x2::tx_context::sender(arg1), arg1));
    }

    // decompiled from Move bytecode v6
}

