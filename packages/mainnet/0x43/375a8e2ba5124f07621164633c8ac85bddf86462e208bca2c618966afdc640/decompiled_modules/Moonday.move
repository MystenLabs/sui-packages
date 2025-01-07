module 0x43375a8e2ba5124f07621164633c8ac85bddf86462e208bca2c618966afdc640::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/Screenshot_2024-07-26_184629.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/Screenshot_2024-07-26_184629.png"))
        };
        0x94650ced50b6ada2a3c042c219211b8384a7bae4c599ab4ae53e01e0759b7fbf::factory::new<MOONDAY>(arg0, 1000000000, b"FRIDAY", b"Friday Coin", b"This  is the first  coin launched on a fridayfor testing. ", v0, false, 0x1::fixed_point32::create_from_rational(100000000, 76557959), arg1);
    }

    // decompiled from Move bytecode v6
}

