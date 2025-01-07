module 0x40b22c7b4af52f38c0264760882ef7f9a4738af60c9ed94a33b541984808a7aa::bluepepe {
    struct BLUEPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEPEPE>(arg0, 6, b"BluePepe", b"Blue Pepe", b"featuring Pepe the Frog in a futuristic neon blue color", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_09_24_045536_f8eaaf027e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

