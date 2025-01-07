module 0x8d5897b459e76502ddea3d1c611b8798cd28cd38f4c032ceb4790c8c55cdcab2::elel {
    struct ELEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEL>(arg0, 6, b"ELEL", b"ELELPHANT ON SUI", b"ELELPHANT LAUNCH ON MOVEPUMP TODAY !! DYOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_18_18_40_58_079bc2d180.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

