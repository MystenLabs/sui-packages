module 0xffb9ed258fb19266cd3b6fd4151f9045ea975dba50b67008b7b54f2d9cd60f31::waterhero {
    struct WATERHERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERHERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERHERO>(arg0, 6, b"WaterHero", b"WaterH", b"https://t.me/waterherosui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_12_20_29_21_f742598f3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERHERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATERHERO>>(v1);
    }

    // decompiled from Move bytecode v6
}

