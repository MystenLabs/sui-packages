module 0x2e23c615de76766bfe0b80c3cf03d1b48bca8446a62f824b95f7fd1300189e45::char {
    struct CHAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAR>(arg0, 6, b"CHAR", b"CHARIZARDcoin", b"FIRST ever PSA graded base set 2 charizard give away!!! To win must be a holder, shilling your brains out with proof, and boost the project!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7135_a1412c77b9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

