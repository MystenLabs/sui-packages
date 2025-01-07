module 0xf8430b337073b78a444474a6d391ad161f57719213b6e49ec18d8d34e3212c99::mpb_ {
    struct MPB_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPB_, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::BondingCurveStartCap<MPB_>>(0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::create_bonding_curve<MPB_>(arg0, b"MPB_", b"Master Polar Bear", b"MPB.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-static.cetus.zone/icon/bd2b294e-37e3-42f3-973d-8239faaafe90")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b7e01f2d63a2993e77dde047aa78ac9741acba774ea70e38ddf7cde7298bf77dbca1312d9d2846d042aff61808691d34a0529386ab736611f992b085c361c00d2b29e6d9d2f97b81d63bdea83da70b8c1ba172cabaeef1786acbe6c04a2125da"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

