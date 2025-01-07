module 0x80a247f6b9e58a3e2d41ffec9f30e5e7aa28f3c5cf81c86d1dcfa0c9396dcb2::fwefd {
    struct FWEFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWEFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWEFD>(arg0, 6, b"FWEFD", b"FWEFF", b"123123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/alex_e129a7e323.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWEFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWEFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

