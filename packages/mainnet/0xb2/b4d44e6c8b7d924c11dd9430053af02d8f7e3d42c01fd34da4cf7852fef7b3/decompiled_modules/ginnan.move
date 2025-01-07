module 0xb2b4d44e6c8b7d924c11dd9430053af02d8f7e3d42c01fd34da4cf7852fef7b3::ginnan {
    struct GINNAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GINNAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GINNAN>(arg0, 6, b"GINNAN", b"Ginnan the Cat", x"50757420596f757220506177730a746f2074686520506176656d656e7421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C7t_KL_Av9_400x400_d925432723.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GINNAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GINNAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

