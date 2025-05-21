module 0x9e87f112f0fde7ec573b47bcfc3d3cdd168cd38ced81647aa3cdf2a6a19e57a6::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CAT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CAT>(arg0, b"CAT", b"Splash Cat", b"First cat on splash", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmazCNzgG5vdu666nFpHEzDRZdHm4bayXcuwxveadx44vN")), b"WEBSITE", b"https://x.com/splashcat_sui", b"DISCORD", b"https://t.me/splashcat_sui", 0x1::string::utf8(b"004190f0cea5ebaf812e7546ca28a7a3f39e11ef2ff1c3227c237504fb8594076551cafd7b06298076c4d00549a7db6ba04b8cf9240725d3ab94279b2af57e6508d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747836266"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

