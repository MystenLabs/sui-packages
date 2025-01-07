module 0x8281d2f35b54b64fe7d2412e6033a3cc37db9a5b0e8d7c0b2422ddbf3e07b8b8::smuirf {
    struct SMUIRF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMUIRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMUIRF>(arg0, 6, b"SMUIRF", b"WILL SMUIRF", b"How come he don't want me, man?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_d758655f71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMUIRF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMUIRF>>(v1);
    }

    // decompiled from Move bytecode v6
}

