module 0x2cc0405cc38d81329f48b52a627b704d1410081d0e63b40e7977eee731e5e11e::jail {
    struct JAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAIL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<JAIL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<JAIL>(arg0, b"JAIL", b"JAILCETUS", b"JAILCETUS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYFYBMmzqMRMJRxGWncrZYdiMw9tH3V3JjQxsHKWXNQjU")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0037ed728e043f98bd0bb8d16823c3cab270ffebb9c6f180fda88c8b5e33652456d8fdfbfd81e260b8143a91b110594ccc77509b6beffebb2141a8f02696d63805d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747912612"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

