module 0x20e17a6ae1191400bde8b050caab918a5397ffb3de7059f969abd38d3d40046::donotbuy {
    struct DONOTBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONOTBUY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DONOTBUY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DONOTBUY>(arg0, b"DONOTBUY", b"DO NOT BUY", b"do not buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmREscHVBeKWpFLYJWswo4XYXpzwesFks3MWwpQn9mjdK6")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0054f76db13859c7446a0d3281707b81e17ab086f0628d9101e798803c85bca42c64598415d1920b5b6edefc1f247a6fcfa4b96f9e4b6dae1abcd6b33f8d612f0dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748101028"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

