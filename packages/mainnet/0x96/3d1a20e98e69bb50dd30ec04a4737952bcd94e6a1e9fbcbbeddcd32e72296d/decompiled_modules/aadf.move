module 0x963d1a20e98e69bb50dd30ec04a4737952bcd94e6a1e9fbcbbeddcd32e72296d::aadf {
    struct AADF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AADF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AADF>(arg0, 6, b"Aadf", b"dfdsadfadfsdfsdfsdfsdafasdf", b"dfads", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suifun_logo1_acd86f94c3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AADF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AADF>>(v1);
    }

    // decompiled from Move bytecode v6
}

