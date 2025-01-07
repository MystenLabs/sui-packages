module 0x4123464877633ce90cc5b948f49851c70668a26c6d76c87d1d26809abc69d9f4::soaked {
    struct SOAKED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOAKED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOAKED>(arg0, 6, b"SOAKED", b"SOAKED SUI", b"SOAKED ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SOAKED_e047c6ef85.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOAKED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOAKED>>(v1);
    }

    // decompiled from Move bytecode v6
}

