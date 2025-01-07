module 0x8cf034c529032983fec956c5ed284de71480865b0bbf09b52bac034e9fa41b61::popcat {
    struct POPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPCAT>(arg0, 6, b"Popcat", b"Popcaaaaaaaaaaaaaaaaaaaaaaaaatttttt", b"The caaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaat that pops", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BFDF_5_F62_1_BEE_4425_8_C60_8_AF_4_B1757709_b0494b3a32.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

