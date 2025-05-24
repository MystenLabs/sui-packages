module 0x360eb5b5ad5eeb27a2973973c19804a0803be8b8a315bc59491e6143c4801a6d::csui {
    struct CSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CSUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CSUI>(arg0, b"CSUI", b"suiclasico", b"I don't intend anything with its creation, just to thank Sui for his great work.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfRdicJK2JtpjNYDRvh3dpxWiPnGdcwDU9c3HhHk2mDxP")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ab354ba67890d6f14a617a61765489cdbf89507af1e3033a3b30a1c1781cba7e1a3ab571fac49fc4a68bd4dd861219cde3591173f3527177270959aaff318c0ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748105591"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

