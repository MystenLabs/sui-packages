module 0x44c3dba9c3092e7a40ac67f69c4997b87b1c661c397906cdd00503ffddbe1c90::usd {
    struct USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<USD>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<USD>(arg0, b"USD", b"USA", b"USA USD Tocken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmW2BhpQm1PUE8BxV69VhVCpdpNDXvEfCkYDE94K96uMZF")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00539a2300b4f4461949af7dae13f548eda4a7d157b0c9e31d8af400b5118f8bba42c6e9c5df50a3f3e5f70418730facb7a131d4f3f638e6eab167a13ddd9d5e0ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747657442"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

