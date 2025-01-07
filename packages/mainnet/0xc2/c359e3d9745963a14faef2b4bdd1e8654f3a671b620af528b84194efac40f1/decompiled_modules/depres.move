module 0xc2c359e3d9745963a14faef2b4bdd1e8654f3a671b620af528b84194efac40f1::depres {
    struct DEPRES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEPRES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEPRES>(arg0, 6, b"DEPRES", b"DepresSUI", b"SUI will change your bad mood....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Depres_SUI_c0b9f72ac6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEPRES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEPRES>>(v1);
    }

    // decompiled from Move bytecode v6
}

