module 0x8cad62defb138b742ae79c4b10145289d161c3f0ca6669cf849eeb3191e252c4::wl {
    struct WL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<WL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<WL>(arg0, b"WL", b"WizardLand", b"WizardLand token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYPHxdaEXoStZuN4gPaKdzhk559yF6jzXSW2traoakUWY")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007d58dacdbcc41189a4971d4c97a93a69e136c7a7b6eacc333b6f57df649003c5343f28dafbbbc5786ad4f7977f11bae657a75dc2e1aa24eb06a4b756008fcb07d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748274687"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

