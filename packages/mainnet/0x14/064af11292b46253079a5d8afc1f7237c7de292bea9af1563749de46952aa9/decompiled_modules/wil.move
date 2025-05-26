module 0x14064af11292b46253079a5d8afc1f7237c7de292bea9af1563749de46952aa9::wil {
    struct WIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<WIL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<WIL>(arg0, b"WiL", b"WizardLand", b"WizardLand token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYPHxdaEXoStZuN4gPaKdzhk559yF6jzXSW2traoakUWY")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0046ec460dc19d80b9eeffe31ce3551bd83d99201d328292e80d42384b93db9479b87218ef8f971122d1f61cfb4f297fb84495b9b9d75e4dea7c792f3ee947d301d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748274973"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

