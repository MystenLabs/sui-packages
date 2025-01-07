module 0xb013a71c50773e96c287d44e4e1f3df9087f329e08ba01fb1885738a0402457::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 6, b"MEOW", b"MEOW ON SUI", b"Destined for the stars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gun_cat_1_min_d7227f8d92.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

