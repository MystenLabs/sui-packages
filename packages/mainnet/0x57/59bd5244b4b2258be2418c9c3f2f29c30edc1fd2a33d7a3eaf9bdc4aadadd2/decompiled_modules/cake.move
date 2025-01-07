module 0x5759bd5244b4b2258be2418c9c3f2f29c30edc1fd2a33d7a3eaf9bdc4aadadd2::cake {
    struct CAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAKE>(arg0, 6, b"CAKE", b"Sui Cake", b"Just a Cake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_18_at_00_35_05_fa3871f1_2d5462418b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

