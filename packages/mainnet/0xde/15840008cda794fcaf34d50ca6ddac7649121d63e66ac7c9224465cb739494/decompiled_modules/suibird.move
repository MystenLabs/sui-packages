module 0xde15840008cda794fcaf34d50ca6ddac7649121d63e66ac7c9224465cb739494::suibird {
    struct SUIBIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBIRD>(arg0, 6, b"SuiBird", b"SuiBirdie", b"a meme coin created on the Sui network, bringing lighthearted fun and community spirit to the blockchain. Our mission? To soar above the crypto landscape with a strong and enthusiastic community backing us.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_19_17_16_27_A_fun_and_playful_logo_for_the_meme_coin_Sui_Bird_The_design_features_a_vibrant_cartoonish_bird_with_a_lighthearted_expression_incorporating_element_37724e87b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

