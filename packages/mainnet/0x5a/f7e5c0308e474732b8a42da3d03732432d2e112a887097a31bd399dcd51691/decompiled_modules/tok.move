module 0x5af7e5c0308e474732b8a42da3d03732432d2e112a887097a31bd399dcd51691::tok {
    struct TOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x4882c0f8e7ad687dcaf0929e1268e3f28f17cc4da074ffc198cbe68b1d3daf94::bonding_curve::create_bonding_curve_v2<TOK>(arg0, b"TOK", b"The", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWrLwEtkJxXtFkjJMHx9Z7xXRqoGZhTgqmq6DuBkJsxs3")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e93ec641decceba3ec5e1e3f99a41c357deb51131c6b04313cfa19ee3ec017007482adb2304626abf05803d5cf5aba878d13ec0a22988aaa8a85a6b512d38d075df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771749473499"), arg1);
        0x2::transfer::public_transfer<0x4882c0f8e7ad687dcaf0929e1268e3f28f17cc4da074ffc198cbe68b1d3daf94::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

