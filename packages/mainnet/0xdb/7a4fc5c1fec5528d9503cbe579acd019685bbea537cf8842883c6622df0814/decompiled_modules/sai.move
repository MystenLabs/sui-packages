module 0xdb7a4fc5c1fec5528d9503cbe579acd019685bbea537cf8842883c6622df0814::sai {
    struct SAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAI>(arg0, 6, b"SAI", b"SaiDoge by SuiAI", b"This token represents the Sui logo, which beautifully embodies the essence of cleanliness, nature, and water-related products. The core element of this logo captures the spirit of pure, boundless nature. Additionally, this token serves as a symbol for an AI agent that is utilized in the fields of nature, agriculture, and travel, aiding in the advancement and improvement of these areas...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Sui_logo_with_a_drop_of_water_and_the_word_Sui_on_a_bright_and_wavy_water_background_that_evokes_a_sense_of_calm_and_gentleness_This_logo_is_a_symbol_of_cleanliness_nature_and_water_related_products_It_is_also_82904d186a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

