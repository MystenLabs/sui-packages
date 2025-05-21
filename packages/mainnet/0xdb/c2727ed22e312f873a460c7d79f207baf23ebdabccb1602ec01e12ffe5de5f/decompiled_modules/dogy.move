module 0xdbc2727ed22e312f873a460c7d79f207baf23ebdabccb1602ec01e12ffe5de5f::dogy {
    struct DOGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DOGY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DOGY>(arg0, b"DOGY", b"DOGGY", b"DOGY DOGY DOGY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcoY1W8sowvMKBXcP1dLFufSR6u5aBmtRkPqyzwz2EN2N")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d5f17e613ea3566eade98e5540d2a24fb236ba4233a3fdc619bc6a79348795ec6b52b8832df8c19d8b4741df27c82c5cc31c7c2900284efaa3107623e7157c06d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747842585"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

