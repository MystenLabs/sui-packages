module 0x335cf1bd33de4d0990eeaeb057ccfaf4654ef6bba223c81476cae6b23ca0be23::croco {
    struct CROCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCO>(arg0, 6, b"CROCO", b"SUICROCO", b"FIRST CROCODILE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gaz9w_Dub0_AA_mx7_745b1fef5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

