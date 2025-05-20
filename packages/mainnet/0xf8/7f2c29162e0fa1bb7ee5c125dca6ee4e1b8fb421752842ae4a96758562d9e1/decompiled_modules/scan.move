module 0xf87f2c29162e0fa1bb7ee5c125dca6ee4e1b8fb421752842ae4a96758562d9e1::scan {
    struct SCAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SCAN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SCAN>(arg0, b"SCAN", b"Splash Scan", b"The perfect Scanner on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYo8C1DMHCAvb4k8C9GvBUMVHHWsvqmQzs4JhUQpUqWZt")), b"WEBSITE", b"https://x.com/SplashScan", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ef33b4e5a2e2dc32ee0a8af0623e27fd5003486773c74ae20727efee950877bc8df7c5bfce111fd835d20e6eabb9d506fc1aa23e4af4403d4acebb319b122e07d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747766440"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

