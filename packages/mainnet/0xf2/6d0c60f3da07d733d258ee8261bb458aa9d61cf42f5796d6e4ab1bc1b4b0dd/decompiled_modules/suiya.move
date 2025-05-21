module 0xf26d0c60f3da07d733d258ee8261bb458aa9d61cf42f5796d6e4ab1bc1b4b0dd::suiya {
    struct SUIYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIYA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIYA>(arg0, b"Suiya", b"Suiyajin", b"We are super suiya jins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQ1Qarm4vLnxB6L1WRtCHqwFPSrM45X3n1JbKVZLrXS8F")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0067a49938028e1de521fa79eff6625836c9e84f4efde484fc334db89b2408193c1257f2318414bd492ef957392df2619a40fb8e92ca4cf14fe4777dc5c9b15d0cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747797546"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

