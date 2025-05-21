module 0xdcaa4df22302c6a812049fe685bec0312792523bb390d1946fdb6998d7ce09ad::nadcor {
    struct NADCOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NADCOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<NADCOR>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<NADCOR>(arg0, b"NADCOR", b"COR", b"monad on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma9QgPJS39L5WZhvLSYJAHjk11er3ukmxqcAhn45YY375")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00fcb960d117abd221212cb3e45d14d63e1632138cb80b4ab052fc942d3657357c4e92c06a64ff0996cc7f9b71e5666dd1d609d5425c16c63926b36d8ebbb24f0dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747851027"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

