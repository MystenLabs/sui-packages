module 0xa431e21890bdad2b4f149e6b77781f1f52c3a5d4dc6dc674c683c1ed3b2b41a4::cvrs {
    struct CVRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CVRS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CVRS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CVRS>(arg0, b"CVRS", b"CampVerse", b"CampVerse is a community token that brings the spirit of camping to the Web3 world. Designed for nature, adventure, and crypto lovers, CampVerse is building an ecosystem where you can join virtual campfire talks, hunt for airdrops, collect camping gear NFT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXmhwTyrwo6NSHcgUk9pP8HPMZLrt13jvedg6PbueLJvP")), b"WEBSITE", b"https://x.com/ompi25", b"DISCORD", b"https://t.me/spirit_airdrop", 0x1::string::utf8(b"00712fa54055bc641fd0124d7a7e4f3bd1e2aaaedd27149f69f1c5f65cf17467ff8e6a1313522146ca9c3d64a3a79606c2834d8502e635c90609a6f7f3e379120bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748074564"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

