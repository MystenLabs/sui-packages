module 0xdad52709757d55c65e01ac732e6aa89269a93c713a7ed5499e48384bf229eff6::iiii {
    struct IIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: IIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x4882c0f8e7ad687dcaf0929e1268e3f28f17cc4da074ffc198cbe68b1d3daf94::bonding_curve::create_bonding_curve_v2<IIII>(arg0, b"IIII", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWrLwEtkJxXtFkjJMHx9Z7xXRqoGZhTgqmq6DuBkJsxs3")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0073a2ad4faa5406f6180da109c0a33a58e53a9f3359d3e3f500f2cc75697408aac234d77abc7195b5c655b3452442ce3825cf6ec39015d6bbf60639b5a582b5055df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771749472751"), arg1);
        0x2::transfer::public_transfer<0x4882c0f8e7ad687dcaf0929e1268e3f28f17cc4da074ffc198cbe68b1d3daf94::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IIII>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

