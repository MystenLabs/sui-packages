module 0x5ba9acbf97592db63bb4fa65ee9dbf10fe97f57a499a76b09ded8da9c5248a0f::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MEME>(arg0, 6, b"MEME", b"memer", b"meme scanner", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2024_12_01_08_49_43_A_creative_depiction_of_a_cryptocurrency_called_Chernobyl_Simulator_The_image_features_a_glowing_digital_coin_with_a_biohazard_symbol_surrounded_b_b73ca24e5e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEME>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

