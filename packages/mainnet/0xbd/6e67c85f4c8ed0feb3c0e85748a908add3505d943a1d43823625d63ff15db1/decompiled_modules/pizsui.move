module 0xbd6e67c85f4c8ed0feb3c0e85748a908add3505d943a1d43823625d63ff15db1::pizsui {
    struct PIZSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZSUI>(arg0, 6, b"PIZSUI", b"PizzaSUi", b"This is the only one best oriogianl SUI PIZZA ON THE WORLD ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5791632844991349373_y_32047a0c8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIZSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

