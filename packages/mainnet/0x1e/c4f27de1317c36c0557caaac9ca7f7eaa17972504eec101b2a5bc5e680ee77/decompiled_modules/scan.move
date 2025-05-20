module 0x1ec4f27de1317c36c0557caaac9ca7f7eaa17972504eec101b2a5bc5e680ee77::scan {
    struct SCAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SCAN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SCAN>(arg0, b"SCAN", b"SplashScan", b"The Number 1 trading tool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUvPTEVR5hRULT5F9trjeBWQMj27kwT5zxN8XEmWrKn65")), b"WEBSITE", b"https://x.com/SplashScan", b"DISCORD", b"https://t.me/HipHop_Launch", 0x1::string::utf8(b"004e16e2a6c404e9c42d68977948dc09a6fdf36c9dd33699fde6fefc8d2f42601d45d984088c78e6552998d62f066ac4c59542cec6cb12a65582a493c8c5e1860dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747771045"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

