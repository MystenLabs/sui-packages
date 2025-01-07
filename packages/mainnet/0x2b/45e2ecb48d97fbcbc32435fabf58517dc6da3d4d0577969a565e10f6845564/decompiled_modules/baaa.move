module 0x2b45e2ecb48d97fbcbc32435fabf58517dc6da3d4d0577969a565e10f6845564::baaa {
    struct BAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAAA>(arg0, 6, b"BAAA", b"Baby aaa cat", b"baby of well known aaa cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4995_cfd6177d03_97450a677f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

