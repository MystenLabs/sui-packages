module 0x2ce318ef6aa2f6b91f5332df5753f4c91885fb08ca7e5d1317fce8d4509a2b2a::kpof {
    struct KPOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: KPOF, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::BondingCurveStartCap<KPOF>>(0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::create_bonding_curve<KPOF>(arg0, b"KPof", b"Kapi on Fire", b"Kapi on Fire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-static.cetus.zone/icon/c94a1929-bfd8-4431-8a6d-c6c160c28514")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000be2941b4c4b5c5f30d9368adfcce886cbb03dfa78aab8c4ba268d835af471ae8c933d14279ad808a6c9a689b407158fd7a643215972bb2eb53f3704805ba4052b29e6d9d2f97b81d63bdea83da70b8c1ba172cabaeef1786acbe6c04a2125da"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

