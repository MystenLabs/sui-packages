module 0xb2940f3af6d3f0671a1b91398f13eaef8e9aad4e9cba802d5bc9bc14120b25ee::tdy {
    struct TDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<TDY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<TDY>(arg0, b"TDY", b"Teddy", x"e2809c49276d2073656c666973682c20696d70617469656e7420616e642061206c6974746c6520696e7365637572652e2049206d616b65206d697374616b65732c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcuKLYSNFySyy1qs1CT2mG7uvVKAPgn5QGUEN5sBm5Hn4")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0030c440cd7ddae12d2e96984f6467a560326236a63b0af949248cc33ce42d2dbc7ba63070091bed084a5eb2f8fd5ce8fd3c68590b0a2fc60c3c84b8472d32c009d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748220024"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

