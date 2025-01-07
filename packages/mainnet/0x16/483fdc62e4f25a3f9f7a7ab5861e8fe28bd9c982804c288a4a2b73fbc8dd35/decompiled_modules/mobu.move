module 0x16483fdc62e4f25a3f9f7a7ab5861e8fe28bd9c982804c288a4a2b73fbc8dd35::mobu {
    struct MOBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBU>(arg0, 6, b"MOBU", b"Monkey Business", b"Welcome to Monkey Business, the next-generation meme coin designed for dreamers, traders, and community builders who love a good laugh with serious gains. Powered by a vibrant community and a cheeky sense of humor, this cryptocurrency embraces the chaos of the markets while offering unique value.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_12_05_21_43_46_A_stylized_cartoon_gorilla_with_a_sarcastic_almost_angry_grin_wearing_a_sharp_blue_suit_The_gorilla_is_depicted_with_arms_crossed_exuding_a_confid_b8a73ae201.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

