module 0x84b511438d357d5886791fecfb77d1759fef1fbae30535ee34907c2dc1ba262f::sobo {
    struct SOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOBO>(arg0, 6, b"SOBO", b"Sobo", b"The Ruthless Trader Bear on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240927_201053_1_1c8f6dd4d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

