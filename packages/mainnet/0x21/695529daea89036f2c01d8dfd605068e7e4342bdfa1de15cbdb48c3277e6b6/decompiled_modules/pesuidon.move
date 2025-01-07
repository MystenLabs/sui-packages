module 0x21695529daea89036f2c01d8dfd605068e7e4342bdfa1de15cbdb48c3277e6b6::pesuidon {
    struct PESUIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESUIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESUIDON>(arg0, 6, b"PESUIDON", b"PEPESUIDON", b"The god of the seven seas and memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_23_50_17_c6c6cbac16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESUIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PESUIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

