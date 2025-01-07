module 0xcb772a65416f4483c7d83658c119755120bdea6e41879c674ae0c1a38c969347::CuteBirdToken {
    struct CUTEBIRDTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTEBIRDTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://cdn.pixabay.com/photo/2024/03/16/20/35/ai-generated-8637800_1280.jpg" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.pixabay.com/photo/2024/03/16/20/35/ai-generated-8637800_1280.jpg"))
        };
        0x1ba416526af31544feaa64b0aa0c61de99aad9bfd474f2fa3ff3351e709df7ac::factory::new<CUTEBIRDTOKEN>(arg0, 1000000000, b"CuteBirdie", b"Cute birdie token", b"A cute birdie coin that can be used for good!", v0, false, 0x1::fixed_point32::create_from_rational(933, 1000), arg1);
    }

    // decompiled from Move bytecode v6
}

