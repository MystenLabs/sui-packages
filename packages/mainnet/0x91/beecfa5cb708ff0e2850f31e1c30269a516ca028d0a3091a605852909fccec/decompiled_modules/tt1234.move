module 0x91beecfa5cb708ff0e2850f31e1c30269a516ca028d0a3091a605852909fccec::tt1234 {
    struct TT1234 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT1234, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<TT1234>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<TT1234>(arg0, b"TT1234", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f9257f17c3b112df43f2fcd328733ebce1a07d1bc365b6fb599a85ffbbbd52812c6f0a475bde823bf3cbd904530e1854c3cf763901137c6725d3c98b06a72004d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747943654"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

