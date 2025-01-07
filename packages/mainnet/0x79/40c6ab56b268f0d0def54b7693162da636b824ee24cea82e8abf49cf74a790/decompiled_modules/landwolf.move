module 0x7940c6ab56b268f0d0def54b7693162da636b824ee24cea82e8abf49cf74a790::landwolf {
    struct LANDWOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LANDWOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LANDWOLF>(arg0, 6, b"LANDWOLF", b"American Landwolf", b"American Landwolf (LANDWOLF)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/American_Landwolf_sss_2163d2a509.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LANDWOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LANDWOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

