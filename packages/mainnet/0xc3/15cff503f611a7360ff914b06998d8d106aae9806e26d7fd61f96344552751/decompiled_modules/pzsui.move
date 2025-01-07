module 0xc315cff503f611a7360ff914b06998d8d106aae9806e26d7fd61f96344552751::pzsui {
    struct PZSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PZSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PZSUI>(arg0, 6, b"PZSUI", b"SUI PIZZA", b"This is the only one best original SUI PIZZA ON THE WORLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5791632844991349373_y_0379b123c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PZSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PZSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

