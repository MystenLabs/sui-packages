module 0xbbd99cb15e00802abc785aa4796b9de4c6b64a15bb3a200519c8e66b8b132614::fffg {
    struct FFFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::BondingCurveStartCap<FFFG>>(0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::create_bonding_curve<FFFG>(arg0, b"FFFG", b"DD", b"GGGG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-static.cetus.zone/icon/08b3d00d-287a-405a-b083-cf1514047636")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0081e627fc98dca35da63525eb6ca5376ac816374fc6a5a8df449e7282ce9a88eba4e4750fc4b75e0ea23082a851711738dad8887cc2bfdfd00aedf773461e31012b29e6d9d2f97b81d63bdea83da70b8c1ba172cabaeef1786acbe6c04a2125da"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

