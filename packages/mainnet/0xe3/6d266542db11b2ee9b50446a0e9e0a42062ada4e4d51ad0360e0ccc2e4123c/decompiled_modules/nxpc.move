module 0xe36d266542db11b2ee9b50446a0e9e0a42062ada4e4d51ad0360e0ccc2e4123c::nxpc {
    struct NXPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NXPC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<NXPC>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<NXPC>(arg0, b"NXPC", b"MXD", b"BIG BIG BIG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeC1YTHR4nKjmkaGoekCSBXsV75Crb1y2bW7bJdVUnxUJ")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f7ae89bebc5f8fa9eed506560976044a362850ceea5a1a4a2330fdea2833a7d330a46c29ed2e5323a22cd8ec3aa837da41c175c9472931a083f1ab680dd67702d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747837314"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

