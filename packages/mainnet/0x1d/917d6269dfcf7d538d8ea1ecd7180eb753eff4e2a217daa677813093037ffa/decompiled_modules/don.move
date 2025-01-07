module 0x1d917d6269dfcf7d538d8ea1ecd7180eb753eff4e2a217daa677813093037ffa::don {
    struct DON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DON>(arg0, 6, b"DON", b"Dolphin", b"Dolphins are incredibly intelligent creatures. Not only do they swim with ease, but they also engage in complex social interactions. They communicate using a series of sounds and whistles, and they even play and cooperate when hunting. Dolphins love to jump in the waves created by boats, showcasing their playful nature. Truly, they are the sprites of the ocean!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zsw90_Ha_AAE_2l_Q_c7e537226a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DON>>(v1);
    }

    // decompiled from Move bytecode v6
}

