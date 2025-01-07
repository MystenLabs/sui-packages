module 0x399444f722948daac7e215df969ff52a5e31032b993ee834ed26c862b2570c63::suiton {
    struct SUITON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITON>(arg0, 6, b"SUITON", b"Suiton", b"SuiTONs are tokenized objects native to the Sui ecosystem, leveraging Sui's Move-based smart contract platform to enable efficient, scalable, and secure decentralized asset management.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_12_17_11_08_34_A_highly_influential_and_viral_meme_style_image_for_a_token_named_Suiton_The_central_focus_is_a_cute_and_funny_water_droplet_mascot_with_cartoonish_c16b979e1f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITON>>(v1);
    }

    // decompiled from Move bytecode v6
}

