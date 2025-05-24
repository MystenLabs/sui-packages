module 0xcf3b188a78e9deb11680efa7e3b19b69701c02982903409bee19e19703e61de5::pasccan {
    struct PASCCAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PASCCAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PASCCAN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PASCCAN>(arg0, b"PASCCAN", b"pascan", b"pascan1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmULCR9A2kbuZzrbNb7QHk8gGCr7SuemptfsbggNMKn3we")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"009a96380c654c7b6ec6010aab7a959078f9f39250c994cf54662e0c2eb02031a1362a05c441f903cda320dbc352e135f64b6bdb31a59f795b69c4a53c16312103d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748082288"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

