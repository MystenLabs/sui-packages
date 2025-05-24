module 0xbf6b0f4506eb332e0e00e0b8adab71b48b2c56ffc9b0df4bdeb55da21cd8e470::shot {
    struct SHOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SHOT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SHOT>(arg0, b"SHOT", b"Last Shot", b"Last Shot (SHOT) is a utility token that supports precise gameplay and performance-based incentives in gaming environments.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUC67SZZbFvrvLyxndY8vyQDig15BG5so2gRBBSFLqj44")), b"https://warpcast.com/0xbamse.eth", b"https://x.com/lastshotofficial", b"DISCORD", b"https://t.me/lastshottoken", 0x1::string::utf8(b"00ba4a5772bdf4c0859ac36a6b556b2f9e398a5d16d08c88f12d7dd18217d397a43a9794ab637ff4ddef297fa4a5ce7b37c69f793fe8320f88948962713587120bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748101368"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

