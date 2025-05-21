module 0xcf416ce43fd8bcc80842bb71742ddb1d33839be76e0f79f416f3712ff4224542::dogy {
    struct DOGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DOGY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DOGY>(arg0, b"DOGY", b"DOGGY", b"DOGY DOGY DOGY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcoY1W8sowvMKBXcP1dLFufSR6u5aBmtRkPqyzwz2EN2N")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"002d643f2a3527008984d78c1665958652c3a7567b5bd7b24474130374408b418524adbc35c67f1a828ffcae41e8906708a31df8e360630a5724908fecf8b7b602d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747841830"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

