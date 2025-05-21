module 0x6283ba4981c7c3352dd85ed54d057d3b6f61634d2ce909f8db5ed460205157df::uc {
    struct UC has drop {
        dummy_field: bool,
    }

    fun init(arg0: UC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<UC>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<UC>(arg0, b"Uc", b"Uc Browser", b"Uc Browser Token Splash", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmarhkTpXyMPnfdts9vMSdh6Fb3fAmbGfqSoteAf9fjcmN")), b"http://uc.com", b"https://x.com/UCBrowser", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00240c96af859516eee14b2f8b2756887e05a2439a93202eed8eaff455fc73d8665c7c5555287d234c00109d29adc39b131fe054e62be14ce81c811df0860b5503d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747795474"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

