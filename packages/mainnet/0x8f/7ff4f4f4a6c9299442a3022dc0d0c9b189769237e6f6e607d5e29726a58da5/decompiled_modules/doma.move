module 0x8f7ff4f4f4a6c9299442a3022dc0d0c9b189769237e6f6e607d5e29726a58da5::doma {
    struct DOMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOMA>(arg0, 6, b"DOMA", b"DOGE ON MARS", b"$DOGEMARS - Doge On Mars is a token inspired by Elon Musks bold vision of creating a thriving civilization on Mars, a place where all of Earths creatures can flourish in a new world. As SpaceX leads humanitys journey to the stars, $DOGEMARS captures the pioneering spirit of exploration and innovation, while embracing the fun and lightheartedness of internet culture, embodied by the beloved Doge meme. This token goes beyond just a playful symbol. It represents the dream of an interplanetary currency, a digital asset that could unite both worlds as we prepare to colonize Mars. With $DOGEMARS, we celebrate not only our technological progress but also our shared imagination and creativity, bridging the gap between Earth and Mars. As humanity reaches for the stars, $DOGEMARS is set to become a lasting symbol of our aspirations, taking the essence of our digital culture with us to the next great frontier.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000198524_3d1af476d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

