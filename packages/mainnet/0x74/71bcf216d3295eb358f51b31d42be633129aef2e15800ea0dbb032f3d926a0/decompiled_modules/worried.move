module 0x7471bcf216d3295eb358f51b31d42be633129aef2e15800ea0dbb032f3d926a0::worried {
    struct WORRIED has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORRIED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORRIED>(arg0, 6, b"WORRIED", b"Worried guy", b"Just a worried Guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016420_34721c9001.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORRIED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORRIED>>(v1);
    }

    // decompiled from Move bytecode v6
}

