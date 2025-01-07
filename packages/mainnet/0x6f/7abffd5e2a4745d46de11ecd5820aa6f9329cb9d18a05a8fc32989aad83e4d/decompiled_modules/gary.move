module 0x6f7abffd5e2a4745d46de11ecd5820aa6f9329cb9d18a05a8fc32989aad83e4d::gary {
    struct GARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARY>(arg0, 6, b"GARY", b"GARY SUI", b"Greatest Of All Time with Gary the $GARY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_09_21_23_05_958c5b58a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARY>>(v1);
    }

    // decompiled from Move bytecode v6
}

