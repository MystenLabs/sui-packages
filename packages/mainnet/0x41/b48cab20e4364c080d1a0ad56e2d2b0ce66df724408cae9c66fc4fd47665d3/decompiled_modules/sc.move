module 0x41b48cab20e4364c080d1a0ad56e2d2b0ce66df724408cae9c66fc4fd47665d3::sc {
    struct SC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SC>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SC>(arg0, b"SC", b"Splash Cat", b"The fastest Splash Cat on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPyZ8baeKhJqwvjoT23pFSa6K9yicjvMwVGZWaMh7G1sp")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00907dcdf93b47e3f94a41caf333be72dc45d7c277f0db9750538c21493a762fcceb7151f8eb7ef5ec65b12f738fbe948d8205e28bb142098b600b24570566860cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747763980"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

