module 0xc382fc86d44322b24cc1165a522d2e9e20492c64850024ee2ac9c0eed6fff910::sofac {
    struct SOFAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOFAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOFAC>(arg0, 6, b"SOFAC", b"SofaCat", b"Every cat loves a cozy sofa, and so does SofaCat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_Fe_Q_Ty_B_400x400_7683e5ddfb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOFAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOFAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

