module 0xeb24c5122f83b4a502bb97a22e5202dd4a4e00baf4bc651e15c3fcbd524e596a::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::BondingCurveStartCap<TEST>>(0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::create_bonding_curve<TEST>(arg0, b"TEST", b"Test", b"des", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-static.cetus.zone/icon/e654f01e-07f1-4351-ba81-7efbfe2f7397")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00eead724cf66137ec18e1911a33a76b2d59ebfb629ee869d4a848be4343d79e9431f617815f0442594c1e665035537805bcb9db302bd58dde2c295eba9f1adf0b2b29e6d9d2f97b81d63bdea83da70b8c1ba172cabaeef1786acbe6c04a2125da"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

