module 0x3d263f1f330c373e8eadc7ad07e944f44f0ed5ad9f937d6030bcf18c5d96332d::milaween {
    struct MILAWEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILAWEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILAWEEN>(arg0, 6, b"Milaween", b"First Milaween on Sui", b"Meet Milaween: https://milaweenonsui.mom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo1_1_4190dee4e5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILAWEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILAWEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

