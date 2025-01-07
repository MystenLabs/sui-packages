module 0xa8f5deab5883cce2ec27fc99b13b76d8bd23f9a124f680e80333919df76800da::suitools {
    struct SUITOOLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOOLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOOLS>(arg0, 6, b"SUITOOLS", b"SuiTools", x"535549546f6f6c7320697320612063757474696e672d6564676520646563656e7472616c697a6564206170706c69636174696f6e20284441707029207461696c6f72656420666f7220746865205355492065636f73797374656d2e200a0a68747470733a2f2f737569746f6f6c732f696f0a68747470733a2f2f737569746f6f6c732f696f2f646f6373", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_03_01_36_37_A_modern_sleek_logo_for_Sui_Tools_incorporating_a_tech_focused_design_The_logo_should_have_a_clean_minimalist_style_with_a_blue_and_white_color_p_5ece9551f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOOLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOOLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

