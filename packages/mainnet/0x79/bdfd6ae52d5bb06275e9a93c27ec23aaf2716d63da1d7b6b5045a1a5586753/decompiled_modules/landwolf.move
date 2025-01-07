module 0x79bdfd6ae52d5bb06275e9a93c27ec23aaf2716d63da1d7b6b5045a1a5586753::landwolf {
    struct LANDWOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LANDWOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LANDWOLF>(arg0, 6, b"LANDWOLF", b"$LANDWOLF", b"$LANDWOLF ON SUI >> ORIGINALLY FROM THE $BOYSCLUBHQ >> MOON <<", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/XSSD_c7887e555e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LANDWOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LANDWOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

