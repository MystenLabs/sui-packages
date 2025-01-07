module 0x7d418e7a47725307df135a783215bc5603d9c399dc392b620c01be6444248a50::igde {
    struct IGDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IGDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGDE>(arg0, 6, b"IGDE", b"IGDEMAN", b"This token comes in peace :)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avatar_filip_648d72dace.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IGDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

