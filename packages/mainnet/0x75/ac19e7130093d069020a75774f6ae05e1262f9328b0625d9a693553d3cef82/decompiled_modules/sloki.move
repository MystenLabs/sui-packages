module 0x75ac19e7130093d069020a75774f6ae05e1262f9328b0625d9a693553d3cef82::sloki {
    struct SLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SLOKI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SLOKI>(arg0, b"SLOKI", b"SloKing", b"SloKing! The Pokemon meme king of Sui. Stake, vault NFTs, and rule the chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSB6aG9jaHtavbLkZgRJhjVnhuaqmJDpxMpY73dy6t6Tz")), b"WEBSITE", b"https://x.com/slokingonsui", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f522a1c49b53b34d282bc02e22a658c4777a545ab2d1b48c3c0e8c4d869162cf8848629659e4e6d79b70423b38ee9556f40332ae43e7e42051fada14de53280bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748248996"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

