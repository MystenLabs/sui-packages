module 0x3b14c213ac7f682b8ca535cc3a3978b843ce4bcd32cc0a5832a0fb66df81dd14::hasbulla {
    struct HASBULLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASBULLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASBULLA>(arg0, 6, b"Hasbulla", b"OFFICIAL HASBULLA SUI", b"The Only Official HasbullahMeme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_042324_350_6b4ecdcdd9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASBULLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HASBULLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

