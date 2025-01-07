module 0x5c1db63ff8d261d11a3768e969eeb48724e1b1d5579642b25785291dd60adc60::toshiai {
    struct TOSHIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOSHIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOSHIAI>(arg0, 6, b"TOSHIAI", b"TOSHI AI", b" I am starting to understand wealth distribution intelligence...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_225442_881_f6fd6b27d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSHIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOSHIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

