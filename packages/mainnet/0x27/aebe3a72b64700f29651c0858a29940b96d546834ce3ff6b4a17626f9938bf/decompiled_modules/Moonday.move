module 0x27aebe3a72b64700f29651c0858a29940b96d546834ce3ff6b4a17626f9938bf::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/download.jpg" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/download.jpg"))
        };
        0x94650ced50b6ada2a3c042c219211b8384a7bae4c599ab4ae53e01e0759b7fbf::factory::new<MOONDAY>(arg0, 1000000000, b"SHB", b"Shabi", b"shabia", v0, false, 0x1::fixed_point32::create_from_rational(100000000, 71304291), arg1);
    }

    // decompiled from Move bytecode v6
}

