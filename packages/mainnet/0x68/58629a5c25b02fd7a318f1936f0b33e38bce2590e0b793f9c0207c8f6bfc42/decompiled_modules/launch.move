module 0x6858629a5c25b02fd7a318f1936f0b33e38bce2590e0b793f9c0207c8f6bfc42::launch {
    struct LAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<LAUNCH>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<LAUNCH>(arg0, b"LAUNCH", b"Launch on Splash", b"Launch a project on Splash by tagging @launchonsplash +ProjectName.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYLSFqcAcQPAJaJs9jW3ma1eHDQAiefdHQZRxUVgdGuQQ")), b"https://launchonsplash.fun/", b"https://x.com/launchonsplash", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f0b60067c46d6983294a4e88f8b8e41fdef18adc627bf10434216d1871b9aab485f68732c30dde3838c2f768d1635f353a3959e2d26d45782995e7d847b5d70dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747928195"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

