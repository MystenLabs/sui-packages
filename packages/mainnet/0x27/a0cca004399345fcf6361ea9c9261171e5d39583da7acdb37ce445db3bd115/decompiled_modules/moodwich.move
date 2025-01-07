module 0x27a0cca004399345fcf6361ea9c9261171e5d39583da7acdb37ce445db3bd115::moodwich {
    struct MOODWICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODWICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODWICH>(arg0, 6, b"MOODWICH", b"MOODWICHSUI", b"If you didn't know, here are just a few ways you can have a bite of Moo Deng on Sui! The original and biggest Moo Deng community there is! Its no wonder we cross 150M volume daily. Thank you to all of our partners!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_G59_W1y_BX_7_YEA_Zo_U94_G_Vnz_P2t27_Z_Gu2y9q9w_Dhnadc5w_2492fc727e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODWICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODWICH>>(v1);
    }

    // decompiled from Move bytecode v6
}

