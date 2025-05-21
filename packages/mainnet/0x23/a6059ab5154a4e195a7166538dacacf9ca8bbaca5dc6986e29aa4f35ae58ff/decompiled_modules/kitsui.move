module 0x23a6059ab5154a4e195a7166538dacacf9ca8bbaca5dc6986e29aa4f35ae58ff::kitsui {
    struct KITSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<KITSUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<KITSUI>(arg0, b"KITSUI", b"Kitten Sui", b"I don't know why I am here, probably not to PUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmectM51qVd1BLe5thtjizY4BuPTdhwUzzyNTnj5WRg57u")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00aebce139223519564db48a8b9293e2dca4c36f9c9f17a3ba0ce905113d4a6f431e7f1d753c1e616365af807d615acecb3f715a360e8c7cd7bfe59a837afd1701d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747825014"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

