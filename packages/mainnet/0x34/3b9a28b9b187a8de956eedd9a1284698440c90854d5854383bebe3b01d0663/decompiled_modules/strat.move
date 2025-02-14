module 0x343b9a28b9b187a8de956eedd9a1284698440c90854d5854383bebe3b01d0663::strat {
    struct STRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRAT>(arg0, 6, b"STRAT", b"STRATTON", b"The STRAT Token is the core utility token of the Stratton Pump ecosystem, built on the Sui Network. Designed to drive community engagement and fuel the platforms Web3 gaming economy, STRAT plays a crucial role in rewarding users and sustaining liquidity through Strattons unique Buyback Model.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/STRATTON_NEW_LOGO_1_6a93823691.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

