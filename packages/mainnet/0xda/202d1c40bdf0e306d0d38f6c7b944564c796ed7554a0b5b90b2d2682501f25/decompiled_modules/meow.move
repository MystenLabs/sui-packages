module 0xda202d1c40bdf0e306d0d38f6c7b944564c796ed7554a0b5b90b2d2682501f25::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MEOW>(arg0, 6, b"MEOW", b"MEOW by SuiAI", b"MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/pexels_photo_2071882_fc3b68548a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEOW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

