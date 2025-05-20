module 0x6401b34c1db9e5929bc57ac097346a7f5e01b0a3f8dc0395ce1b945262a4dc38::gigapo {
    struct GIGAPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGAPO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<GIGAPO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<GIGAPO>(arg0, b"GIGAPO", b"Giga Hippo", b"The Strongest Hippo on the Internet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYS28Pux6Pm9oE25U9F9hCwbZBurxszTNNpjwQ3RKLnWw")), b"https://gigahippo.fun/", b"https://x.com/_gigapo", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00df8a26657e80189d4937918e72ceb0fa7abd0e78f94afa8fe11238442bfd03ef0131d2a2a7adcc8c5c47dc931fd496c944435105d287ac536c804e9538a03903d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747775053"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

