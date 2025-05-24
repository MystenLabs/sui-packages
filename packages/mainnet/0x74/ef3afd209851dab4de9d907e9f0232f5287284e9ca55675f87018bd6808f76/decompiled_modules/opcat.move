module 0x74ef3afd209851dab4de9d907e9f0232f5287284e9ca55675f87018bd6808f76::opcat {
    struct OPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<OPCAT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<OPCAT>(arg0, b"OPCAT", b"Kayden", b"Stongest Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQ9ayEYohJZQzsbXUFy8PEdzWxSRfwSutVF1XDwB2aWb5")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00fe6ea0afe922b8f853f55cec253052654ec604abcb84cb3a6ee77a8aaede1d2d81f9d2da6f62653eeda3229ad04ea9466313fcb643148c20d3a2444423faa80ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748108552"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

