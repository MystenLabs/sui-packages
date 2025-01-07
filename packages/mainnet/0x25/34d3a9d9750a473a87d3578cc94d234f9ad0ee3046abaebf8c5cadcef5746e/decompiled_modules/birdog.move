module 0x2534d3a9d9750a473a87d3578cc94d234f9ad0ee3046abaebf8c5cadcef5746e::birdog {
    struct BIRDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDOG>(arg0, 6, b"BIRDOG", b"BirdDog", b"Bird Dog is a COMMUNITY OWNED token celebrating the coolest member of the Boys Club alongside Pepe, Brett, Wolf and Andy! The Boys Club is finally complete with BIRD DOG!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5483_42d13ab3e9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

