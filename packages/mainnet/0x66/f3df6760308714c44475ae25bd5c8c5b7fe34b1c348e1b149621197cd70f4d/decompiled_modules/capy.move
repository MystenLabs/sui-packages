module 0x66f3df6760308714c44475ae25bd5c8c5b7fe34b1c348e1b149621197cd70f4d::capy {
    struct CAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPY>(arg0, 6, b"CAPY", b"The Capy", b"Capy is a calm, curious capybara with a love for adventure. Friendly and laid-back, they enjoy solving problems with quiet wisdom and a quirky sense of humor. Always surrounded by friends, Capys easy-going nature makes them the perfect companion on any journey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c24f6f7416b40f005a2308ca407ab9e9_e22e728170.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

