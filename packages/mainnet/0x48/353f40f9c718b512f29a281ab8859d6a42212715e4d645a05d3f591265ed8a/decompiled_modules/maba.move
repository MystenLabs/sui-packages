module 0x48353f40f9c718b512f29a281ab8859d6a42212715e4d645a05d3f591265ed8a::maba {
    struct MABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MABA>(arg0, 6, b"MABA", b"Make America Based Agaian", b"Make America Based Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1558_d4c6bd34f8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

