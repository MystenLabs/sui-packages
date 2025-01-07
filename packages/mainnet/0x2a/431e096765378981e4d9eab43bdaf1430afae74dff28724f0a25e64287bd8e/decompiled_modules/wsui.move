module 0x2a431e096765378981e4d9eab43bdaf1430afae74dff28724f0a25e64287bd8e::wsui {
    struct WSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSUI>(arg0, 6, b"WSUI", b"Wonder SUI", b"WSUI is not wrapped SUI it's just wonder SUI the best super hero on SUI Network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_14_17_52_56_A_logo_for_a_meme_token_called_WONDER_SUI_representing_a_blue_superhero_The_design_features_a_stylized_superhero_character_with_a_bold_blue_color_s_736ef52cf6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

