module 0x241cf796b46f8b8e9f10ffabd32faa38eb025a4e6d7c7d8e091c702e7ea3dce1::peng {
    struct PENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENG>(arg0, 6, b"PENG", b"Pump Penguin", b"I must admit, I am created by AI, which train robots to make me pump. So thats my name, pump! And I am a penguin, there by the last name, Penguin! My enemy is the Goat, which I intend to outperform, by zillions! At least Billions! I wear more gold that Donald! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_30_16_27_54_A_confident_stylish_penguin_character_named_Pump_Penguin_dressed_in_a_sharp_pinstripe_suit_jacket_with_a_silk_pocket_square_He_wears_a_chunky_gold_aa142556f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

