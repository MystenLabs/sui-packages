module 0x41d6fd5abca60e40e78b417d1605a13df9cf8b306054cbd23395cd7e2112b97d::chriblu {
    struct CHRIBLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHRIBLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHRIBLU>(arg0, 6, b"Chriblu", b"chriplu", x"206d656d65207265766f6c7574696f6e2068617320626567756e2c20616e642043687269706c75206973206c656164696e6720746865206368617267652e2054686520776f726c642069732061626f757420746f2073656520746865206d61676963206f66206d656d6573206c696b65206e65766572206265666f726521220a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_26_19_39_53_A_cute_cartoon_style_round_bird_character_exactly_like_the_original_but_in_Sui_blue_color_The_character_should_have_large_shiny_eyes_a_small_beak_8a44910ef8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRIBLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHRIBLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

