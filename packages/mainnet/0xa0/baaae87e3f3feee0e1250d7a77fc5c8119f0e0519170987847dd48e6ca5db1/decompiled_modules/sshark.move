module 0xa0baaae87e3f3feee0e1250d7a77fc5c8119f0e0519170987847dd48e6ca5db1::sshark {
    struct SSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<SSHARK>(arg0, b"SSHARK", b"SuiShark", b"First SHARK'S  on SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRKut5D8ThGE4kDhAVGyYPh5ubu7RoHHoDsZ3QXmsMeYn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00eedccaecd224cd2b5a8c5d3da37e0ef3975bb5eb97692d79d0bd424758effdf5b25c5f4205c2c5e86d2f96eba14d94516cd3f5d02fcf96983c16a7c401a32806d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1757074064"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSHARK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

