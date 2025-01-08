module 0xe3854e5527f31e1063f9ae33076dc362507bbb950ff458d3066ce834e14dc959::tama {
    struct TAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TAMA>(arg0, 6, b"TAMA", b"SUITAMA by SuiAI", b"Years ago, Saitama the famous One Punch Man was a struggling crypto enthusiast trying to understand DeFi, NFTs, and the latest memecoins. After losing everything in a massive rug pull on an untrustworthy blockchain, he vowed to become 'strong enough to eliminate all scams in one punch.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/One_Punch_Man_8e4df34299.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAMA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAMA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

