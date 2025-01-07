module 0x889a2c043fcba4e7c2bba8f6dc08492a1320885ce4fc29b4700579eaf9799807::suibert {
    struct SUIBERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBERT>(arg0, 6, b"SUIBERT", b"Suibert", x"537569626572742069732074686520627261696e6961632065766572792063727970746f2066616d696c79206e65656473210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suibert_e79926e11d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

