module 0xd5eb6cd56bd452bece507e9ca1cc260143a6aa16c836f83788bf5b54ca64aa29::garf {
    struct GARF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARF>(arg0, 6, b"Garf", b"Garfled", b"Where is the mother fucking lasagna Jon?!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Garfeldman_926106c126.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARF>>(v1);
    }

    // decompiled from Move bytecode v6
}

