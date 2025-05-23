module 0x8cc9a5f51c72db0293cb1a2301c72cf709da5452b3fa8f74b6f2222fb189e887::rr12345 {
    struct RR12345 has drop {
        dummy_field: bool,
    }

    fun init(arg0: RR12345, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<RR12345>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<RR12345>(arg0, b"RR12345", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e160c93fe33f43874cc6be175f8d34cdcc78458829f6bb037c2619aa332c4c14e2021e621fa76aa8077fccbdd6d9d7b1992fb6106011c2a09a10752043186a07d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747991375"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

