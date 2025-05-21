module 0x1d6a730ff972173978042640df10b40d0929f6dc8baaed9d2ac69bd9befd2fe3::rr1 {
    struct RR1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: RR1, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<RR1>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<RR1>(arg0, b"RR1", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00fb23a8968b5cb84e851a1b70ed3ab172bfb576d19809764b48951ca2ebae300c451d6304946d7bf162e50aa776cdbdfa80aa034a349b86c7ca4b56015e94cc09d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747863767"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

