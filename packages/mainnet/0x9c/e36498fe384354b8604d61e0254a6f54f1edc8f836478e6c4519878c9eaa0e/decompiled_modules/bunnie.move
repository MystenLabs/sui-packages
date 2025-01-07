module 0x9ce36498fe384354b8604d61e0254a6f54f1edc8f836478e6c4519878c9eaa0e::bunnie {
    struct BUNNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNIE>(arg0, 6, b"BUNNIE", b"Bunnie on sui", b"Just a bunnie hopping out of the trenches.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241221_182946_739_f2d3afd3d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNNIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

