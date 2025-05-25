module 0x5b22cde58f6429d3b4b529a54e12778c9c2d5d43b9e904abd9397abfdddee810::bd {
    struct BD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BD>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BD>(arg0, b"BD", b"BADSHA", b"GAMING NFT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWZ7TiqbQ5NqwhEjsYumcmGo3bmCH4wjN2LyueozYbT4z")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"003285041d4ae503a643da55ed07f943117a66441681d5581a2398e814f9388a448030f375d90c9104c35a6128bee532d25f33173b2fd99392fc6c875f502b970bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748167744"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

