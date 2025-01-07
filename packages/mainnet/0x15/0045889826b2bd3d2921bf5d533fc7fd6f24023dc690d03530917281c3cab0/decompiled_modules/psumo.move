module 0x150045889826b2bd3d2921bf5d533fc7fd6f24023dc690d03530917281c3cab0::psumo {
    struct PSUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSUMO>(arg0, 6, b"PSUMO", b"Pepe Sumo", b"The undefeated heavy weight champion of memes !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015716_ccba2ed772.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSUMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSUMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

