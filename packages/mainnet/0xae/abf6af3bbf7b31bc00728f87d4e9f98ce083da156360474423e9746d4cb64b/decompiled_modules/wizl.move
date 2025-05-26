module 0xaeabf6af3bbf7b31bc00728f87d4e9f98ce083da156360474423e9746d4cb64b::wizl {
    struct WIZL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<WIZL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<WIZL>(arg0, b"WizL", b"Wizard", b"When there are 10,000 SUI deposited into this bonding curve, all its liquidity will be migrated into Cetus CLMM pool and the initial liquidity will be burned. Progression increases as the price goes up.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYPHxdaEXoStZuN4gPaKdzhk559yF6jzXSW2traoakUWY")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b5660939a72f0635e8286cdcf7902440c5a68fe4b6949c09a01d38fe72551a646700a2b301fd279bf1a25a364b78f5b664925a0f6a2dd4e3863d5c39b100840dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748275154"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

