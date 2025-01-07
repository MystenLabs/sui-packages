module 0xfdb4a26a8f442e2d1b9179147aa5d2a4a2c4fe60af48e9ab7ff410019361fa82::milaaa {
    struct MILAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILAAA>(arg0, 6, b"Milaaa", b"Mila", b"This is the sweetest girl in the world! Her name is Mila!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_20_42_15_7cfd4ea059.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

