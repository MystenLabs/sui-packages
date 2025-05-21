module 0x7bf5c7a2390c50f419dc5a7d996653144108039b5d9adee40a451e7db92b93f4::scg {
    struct SCG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SCG>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SCG>(arg0, b"SCG", b"SuiCapyGen", b"Cappy most powerfull animal can make great life and live on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfUdZZREVbtAuQVGQ1m8H5te3i97ppCbAv3BVr7rG227h")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00071060a5c92867033ecaa5476f52880a1596d717d664f2502594f8aba6972e8c61f957cdf3380e0f6d2336bf4dc175a88724652c8dd88070d3abda2b664af903d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747814076"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

