module 0x4640654add1a400b9c6c96088e3d0b70c2d4436e05903549089d432ac4a9138b::suiri {
    struct SUIRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIRI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIRI>(arg0, b"SUIRI", b"SUIRI ON SUI", b"SUIRI ON SUI LIVE!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXJ5AYXYvb3pyTG4bCNKejpbmDY1yrNUhxWRtWzRYhR7h")), b"https://suirionsui.com/", b"https://x.com/SuiriOnSui", b"DISCORD", b"https://t.me/suirionsui", 0x1::string::utf8(b"003094208dbd168d0486b39db7aac90d66c74e3e5d7000b205689a29a6d946f91c5a4c2df96911819d0069ee535ebc0b83a580a2c23ef5033f508a28750975ab03d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757771"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

