module 0xbb8a54dd83e0b7b08f7039174aeee35f2b638ac7b438e46a2b4f8c8c463f22f6::freg {
    struct FREG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREG>(arg0, 6, b"FREG", b"FREG ON SUI", b"Wherever you go, $FREG will always be there to accompany you :)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/freg_4dc802ecb7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREG>>(v1);
    }

    // decompiled from Move bytecode v6
}

