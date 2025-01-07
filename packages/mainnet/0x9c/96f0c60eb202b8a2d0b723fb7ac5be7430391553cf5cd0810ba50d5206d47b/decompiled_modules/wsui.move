module 0x9c96f0c60eb202b8a2d0b723fb7ac5be7430391553cf5cd0810ba50d5206d47b::wsui {
    struct WSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSUI>(arg0, 6, b"WSUI", b"WaterMelon", x"57617465724d656c6f6e20537569204c6976650a0a536f6369616c206d656469612077696c6c20626520757064617465642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_09_11_22_36_A_fun_meme_style_image_blending_a_watermelon_and_Sui_Network_elements_into_a_comical_shit_token_theme_The_watermelon_could_have_Sui_Network_symbols_d389ae8c4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

