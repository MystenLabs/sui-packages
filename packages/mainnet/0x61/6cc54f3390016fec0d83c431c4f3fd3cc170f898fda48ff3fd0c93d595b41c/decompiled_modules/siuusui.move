module 0x616cc54f3390016fec0d83c431c4f3fd3cc170f898fda48ff3fd0c93d595b41c::siuusui {
    struct SIUUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUUSUI>(arg0, 6, b"SIUUSUI", b"SIUU SUI", b"RONALDO OF SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_7a998e14d0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIUUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

