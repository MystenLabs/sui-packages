module 0x2a3e6a381e1072a5b7b27087d40396f049f2c77ad77de18809ce686a30bcb43e::tt1255 {
    struct TT1255 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT1255, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x4882c0f8e7ad687dcaf0929e1268e3f28f17cc4da074ffc198cbe68b1d3daf94::bonding_curve::create_bonding_curve_v2<TT1255>(arg0, b"TT1255", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWrLwEtkJxXtFkjJMHx9Z7xXRqoGZhTgqmq6DuBkJsxs3")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0045f43044af8bb9e4e473082c64014ca8c1a04c0f106813c6a1589b8b0223aa319180f3953fe745f9350a7a949646c85c2d8f141e71b394f6aa5a1ee3ab0440055df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771749472658"), arg1);
        0x2::transfer::public_transfer<0x4882c0f8e7ad687dcaf0929e1268e3f28f17cc4da074ffc198cbe68b1d3daf94::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT1255>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

