module 0xcde836b47b056497a0f6a0369b3a6bd0f48e80f0c8f98f954e55d37d6145f90a::dop {
    struct DOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOP>(arg0, 6, b"DOP", b"Dop", b"THE ONLY DOLPHIN SWIMMIN' ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7556_1_27d5d6856e.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

