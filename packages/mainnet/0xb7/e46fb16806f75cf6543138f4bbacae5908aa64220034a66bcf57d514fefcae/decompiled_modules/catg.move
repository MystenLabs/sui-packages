module 0xb7e46fb16806f75cf6543138f4bbacae5908aa64220034a66bcf57d514fefcae::catg {
    struct CATG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATG>(arg0, 6, b"CatG", b"Andrew Cate", b"Escape the meowtrix", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_05_15_45_30_A_digital_illustration_of_a_blue_cat_inspired_by_the_style_of_Andrew_Tate_The_cat_has_a_confident_and_bold_expression_with_a_sleek_muscular_build_a_3dbe369a7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATG>>(v1);
    }

    // decompiled from Move bytecode v6
}

