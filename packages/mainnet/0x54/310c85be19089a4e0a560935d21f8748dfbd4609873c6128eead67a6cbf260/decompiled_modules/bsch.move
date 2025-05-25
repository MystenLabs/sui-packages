module 0x54310c85be19089a4e0a560935d21f8748dfbd4609873c6128eead67a6cbf260::bsch {
    struct BSCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSCH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BSCH>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BSCH>(arg0, b"BSCH", b"BLUE SLUCH", b"BLUE SLUCH BLUE SPLASH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRXJKUxrEXtgZN8pMm8RGd4z44PNGUy4GjiKFsTBXLkwE")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c2325ed2116f1c4c01b5a95023033df9e274c1276d3fe2d1bd5e8b661324657230f6625ad07be5f545accc945f6ddf80e5a33dc7a8e4b63e3064a2d7a164720ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748196821"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

