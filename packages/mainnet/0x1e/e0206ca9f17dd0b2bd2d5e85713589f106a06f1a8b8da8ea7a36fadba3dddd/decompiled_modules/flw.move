module 0x1ee0206ca9f17dd0b2bd2d5e85713589f106a06f1a8b8da8ea7a36fadba3dddd::flw {
    struct FLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<FLW>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<FLW>(arg0, b"FLW", b"FLOW", b"LALA moves like the wind but not on waves to freedom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSB5Qj9kEk5kL221gLf8xkFFiXbnLgT6uGK4GqgZ8irfv")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e6a74c4ff0e08384a398f3ccee75b9777d0f4d5320c8af79cef9f5f0848380864ccc717fed12ef005e1a34f157ab86aecf5604fabae2db6c8b7515d654265401d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748180224"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

