module 0xf193c07120505f028267c63fedfd9d6f576aaa433f12bb51bd5f0eda2411a5d5::penguin {
    struct PENGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUIN>(arg0, 6, b"PENGUIN", b"Pump Penguin", b"Pump Penguin has the look of a flashy, overly confident penguin, dressed in a mix of Wall Street glamour and hip-hop swagger. Pump Penguin embodies a blend of comical extravagance and financial savvy, representing the hype and pump mentality that makes him a beloved mascot in the meme coin community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_30_16_27_54_A_confident_stylish_penguin_character_named_Pump_Penguin_dressed_in_a_sharp_pinstripe_suit_jacket_with_a_silk_pocket_square_He_wears_a_chunky_gold_51c18183b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

