module 0x9e6bd33e5f8a51ab3c7e50b252df4ac67ae664fa9c823aa0f3fc77ed13e72e0e::riley {
    struct RILEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RILEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RILEY>(arg0, 6, b"RILEY", b"RileyReidWifPickleRick", b"Riley is already horny don't miss the show!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_01_28_19_31_47_ae2d6f4a30.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RILEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RILEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

