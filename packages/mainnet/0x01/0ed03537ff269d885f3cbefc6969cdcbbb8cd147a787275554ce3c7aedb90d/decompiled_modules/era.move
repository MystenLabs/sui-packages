module 0x10ed03537ff269d885f3cbefc6969cdcbbb8cd147a787275554ce3c7aedb90d::era {
    struct ERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<ERA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<ERA>(arg0, b"ERA", b"CALDERA", b"This is just for experiment and fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUyxie4jY1gJjEQp7fa4H4ykeQeDfhvfUN5zsePV4yKMe")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00646ab5b0874c8b0c74534e0a82d2f6db111917324d018bc91f5ce6d8ec191ab5272e14355bfdbe7942c81fa23b22bf8c084a92514cba156c3dde2a843ce9f804d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747775799"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

