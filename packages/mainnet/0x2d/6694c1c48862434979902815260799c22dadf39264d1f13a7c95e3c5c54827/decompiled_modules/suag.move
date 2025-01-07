module 0x2d6694c1c48862434979902815260799c22dadf39264d1f13a7c95e3c5c54827::suag {
    struct SUAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUAG>(arg0, 6, b"SUAG", b"SUAG BIRD", b"IM SUAG THE BIRD, NOT SWAG, SUAG.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3688_7074b0369f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

