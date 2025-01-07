module 0xf69455cda8a06bc38ba724068871cd1483c007786c9a57e9a2d149b1eaee722c::CuteBirdToken10 {
    struct CUTEBIRDTOKEN10 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTEBIRDTOKEN10, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://cdn.pixabay.com/photo/2024/03/16/20/35/ai-generated-8637800_1280.jpg" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.pixabay.com/photo/2024/03/16/20/35/ai-generated-8637800_1280.jpg"))
        };
        0x1ba416526af31544feaa64b0aa0c61de99aad9bfd474f2fa3ff3351e709df7ac::factory::new<CUTEBIRDTOKEN10>(arg0, 1000000000, b"CuteBirdie10", b"Cute birdie token 10", b"A cute birdie coin 10 that can be used for good!", v0, false, 0x1::fixed_point32::create_from_rational(933, 1000), arg1);
    }

    // decompiled from Move bytecode v6
}

