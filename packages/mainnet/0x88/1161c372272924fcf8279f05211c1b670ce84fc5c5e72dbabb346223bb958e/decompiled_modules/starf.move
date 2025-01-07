module 0x881161c372272924fcf8279f05211c1b670ce84fc5c5e72dbabb346223bb958e::starf {
    struct STARF has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARF>(arg0, 6, b"STARF", b"StarFish", b"A starfish wandering in the sea, afraid of being eaten by big fish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OW_8_MX_Ciy_400x400_79e490d1ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARF>>(v1);
    }

    // decompiled from Move bytecode v6
}

