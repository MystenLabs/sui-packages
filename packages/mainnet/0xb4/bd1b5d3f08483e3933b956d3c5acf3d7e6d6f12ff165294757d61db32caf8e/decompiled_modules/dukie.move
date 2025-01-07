module 0xb4bd1b5d3f08483e3933b956d3c5acf3d7e6d6f12ff165294757d61db32caf8e::dukie {
    struct DUKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKIE>(arg0, 6, b"DUKIE", b"SUI DUKIE", b"Dukie in the toilet  not on the chart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241226_214349_427_d734a38dfe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

