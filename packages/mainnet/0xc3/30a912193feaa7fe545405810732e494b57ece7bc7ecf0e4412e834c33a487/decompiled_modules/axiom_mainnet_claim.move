module 0xc330a912193feaa7fe545405810732e494b57ece7bc7ecf0e4412e834c33a487::axiom_mainnet_claim {
    struct AXIOM_MAINNET_CLAIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXIOM_MAINNET_CLAIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXIOM_MAINNET_CLAIM>(arg0, 6, b"AMC", b"AXIOM MAINNET CLAIM", b"Axiom Protocol community rewards token. COMMUNITY REWARDS ONLY. No monetary value. Not AXUSD, AXAU, AXM, SEED, or KAG. Not backed by any reserve. Not redeemable.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AXIOM_MAINNET_CLAIM>>(v1);
        0x2::transfer::public_transfer<0xc330a912193feaa7fe545405810732e494b57ece7bc7ecf0e4412e834c33a487::guarded_treasury::GuardedTreasury<AXIOM_MAINNET_CLAIM>>(0xc330a912193feaa7fe545405810732e494b57ece7bc7ecf0e4412e834c33a487::guarded_treasury::create<AXIOM_MAINNET_CLAIM>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

