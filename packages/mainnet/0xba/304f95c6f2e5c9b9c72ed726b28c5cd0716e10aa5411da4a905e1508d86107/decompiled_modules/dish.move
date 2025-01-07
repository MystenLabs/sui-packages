module 0xba304f95c6f2e5c9b9c72ed726b28c5cd0716e10aa5411da4a905e1508d86107::dish {
    struct DISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DISH>(arg0, 6, b"DISH", b"Dog Fish", b"It's a dish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dish_65029db6f5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

