module 0xe5dbc1326566caa4e7cea2c3fdedbe81f4b5160dd782600e38c3f79fb7303825::s1024 {
    struct S1024 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S1024, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S1024>(arg0, 6, b"S1024", b"Sui1024", x"41206d6f736169632d7374796c6520696d6167652077697468206c696e6573206f6620636f646520696e206d756c7469706c652070726f6772616d6d696e67206c616e6775616765732c206561636820656e64696e672077697468202768656c6c6f20776f726c64272e2045616368206c696e65206f6620636f6465207573657320636f6d6d656e747320616e642066756e6374696f2e0a2d2d53616c75746520746f20616c6c2070726f6772616d6d657273", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_24_16_42_05_A_mosaic_style_image_with_lines_of_code_in_multiple_programming_languages_each_ending_with_hello_world_Each_line_of_code_uses_comments_and_functio_f4b0f9f781.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S1024>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S1024>>(v1);
    }

    // decompiled from Move bytecode v6
}

