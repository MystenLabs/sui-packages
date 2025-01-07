module 0xb642e4d729efb4e21512bb4c13959245a452f26cdff37d71e431096299c7c0e3::dilli {
    struct DILLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DILLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DILLI>(arg0, 6, b"DILLI", b"DILLIGAF", x"44494c4c49474146204e6174696f6e3a204a6f696e20746865205265766f6c7574696f6e206f66204e6f7420436172696e670a43727970746f20776974686f7574207468652042532e0a576520646f6e277420636172652c2062757420796f752073686f756c642e0a484f444c20696620796f752044474146210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_22_20_08_07_A_bold_fun_meme_token_graphic_for_DILLIGAF_The_background_is_a_vibrant_neon_green_with_splashes_of_purple_giving_it_an_energetic_playful_vibe_T_eaa9d58d96.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DILLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DILLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

