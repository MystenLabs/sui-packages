module 0xa90fda507e4cdfbd3314a86b78343a214b48da9e6cae4aa51e0ee71a0c08ae17::gmes {
    struct GMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMES>(arg0, 6, b"GMES", b"GameStop", b"Join the movement!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5817_a402e75b7f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

