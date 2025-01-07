module 0xf15ae987375536748892a4ca3a169cc06986288bb06914fa949fa663b04083fa::smem {
    struct SMEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMEM>(arg0, 6, b"SMEM", b"SuiMeme", b"SuiMeme (SMEM) is an experimental memecoin created on the SUI blockchain. Its mission is to merge the power of internet culture with decentralized finance technology. The token's logo features a playful meme-style face surrounded by digital elements and blockchain symbols, representing both technological innovation and fun. Bright colorselectric blue, neon green, and silveremphasize the modern and futuristic nature of the project. SuiMeme embodies innovation and humor, offering users not just a digital asset, but a way to engage in the digital community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_03_19_41_31_A_test_memecoin_called_Sui_Meme_with_ticker_SMEM_on_the_SUI_blockchain_The_coin_features_a_playful_futuristic_design_with_a_bright_bold_color_pa_cde8f2b22b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

