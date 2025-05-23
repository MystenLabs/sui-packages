module 0x998f2d94f797655c7e7727879961e9287df8672dddd1f92fb058c5c85597a0f5::cetus {
    struct CETUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CETUS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CETUS>(arg0, b"CETUS", b"We believe in Cetus", b"We believe in Cetus Protocol's strength and resilience. We stand united in supporting Cetus Protocol through this challenge. Together, we trust that Cetus Protocol will rise stronger than ever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYFYBMmzqMRMJRxGWncrZYdiMw9tH3V3JjQxsHKWXNQjU")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f1fdd2aac002e61a309332cea88fe00a2f1c37d65e023f007c5bc26991ef9928955c8231af34c8aabb2667322f160593ce20a6189fc681f4b6659bdaf9937506d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747993346"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

