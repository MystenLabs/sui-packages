module 0x60c82f297d203a50cc93c99a7e80ad901c0ff98a269da34d391166fe4772be91::thor {
    struct THOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: THOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<THOR>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<THOR>(arg0, b"THOR", b"Thorianos", b"far from home", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNu7d4NLSja9o4ndcFBwqbqb4T7FwqmC45P2ApymtNqrM")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b8a4b8f8f7dc099a16786955fd0cf39c3d4cd36348e61108b91a909e0ae7e5a904d24256e5ca02efbf85a1df0ca5053b257dcee8fc0589dc9a1275739a9bad01d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748172285"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

