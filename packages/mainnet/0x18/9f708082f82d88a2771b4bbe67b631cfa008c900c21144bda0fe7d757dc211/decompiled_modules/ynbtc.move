module 0x189f708082f82d88a2771b4bbe67b631cfa008c900c21144bda0fe7d757dc211::ynbtc {
    struct YNBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: YNBTC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<YNBTC>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<YNBTC>(arg0, b"YNBTC", b"YN", b"yn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmX7uPWhj9ExvfUj3o7ByXcRGqCoHUbpEbKufnXt1yQNtv")), b"WEBSITE", b"https://x.com/yn_btc", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"003aecb14fe600708150d62e517c7da07fb2cab35f963dc0f2d41040fb430f43461f1a16487fc5f919a8f577eccf4774d9e21223de9eaadea96ea6af84caa25802d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747761180"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

