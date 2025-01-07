module 0x586761d5cfb1c77ed8e403af112380a980e1589005133973db240ce97179b152::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/sweet-birthday-cake-with-candles_18591-82310.avif" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/sweet-birthday-cake-with-candles_18591-82310.avif"))
        };
        0x94650ced50b6ada2a3c042c219211b8384a7bae4c599ab4ae53e01e0759b7fbf::factory::new<MOONDAY>(arg0, 1000000000, b"BDAY", b"Birthday", b"Birthday cake", v0, false, 0x1::fixed_point32::create_from_rational(100000000, 72950128), arg1);
    }

    // decompiled from Move bytecode v6
}

