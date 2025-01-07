module 0x47cf2c020bf3e4470fcd75278c19ce3bb4a11df0c8b9bf7dc89bc88ca6c434bf::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATER>(arg0, 6, b"WATER", b"Water", b"Drink water, stay hydrated! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WET_TRH_Ej_Y_FB_Cje8_OSYJ_86_6bfacb6d21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

