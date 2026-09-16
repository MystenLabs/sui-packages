module 0xe37cdfbf1b4ce0acc7570a75aa1a186cc887da56e0930de3ecaf31883ee4fea3::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"084b555441424952450ce3818fe3819fe3818fe381befc01e6af8ee697a5e3819de3828ce381a7e38282e4bc9ae7a4bee381abe9809ae38184e381aae3818ce38289e38081e38195e38195e38284e3818be381aae887aae5b7b1e998b2e8a19be38292e7b69ae38191e3828b32e58cb9e381aee796b2e3828ce3819fe382afe3839ee3819fe381a1e381aee38081e58fafe6849be3818fe381a6e381a1e38287e381a3e381a8e381bbe3828de88ba6e38184e697a5e5b8b8e38282e381aee380827c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f6b757461626972655f6b756d61222c2277656273697465223a22616d617a6f6e2e636f2e6a702f64702f343034333330303432352f227d2068747470733a2f2f692e696d6775722e636f6d2f5147426c496a672e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

