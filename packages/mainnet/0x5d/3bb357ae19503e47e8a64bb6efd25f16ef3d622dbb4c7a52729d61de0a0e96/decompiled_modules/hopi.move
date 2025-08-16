module 0x5d3bb357ae19503e47e8a64bb6efd25f16ef3d622dbb4c7a52729d61de0a0e96::hopi {
    struct HOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPI>(arg0, 6, b"HOPI", b"Hoppi", b"Pumping is My Hoppi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hoppy_051af56c45.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

