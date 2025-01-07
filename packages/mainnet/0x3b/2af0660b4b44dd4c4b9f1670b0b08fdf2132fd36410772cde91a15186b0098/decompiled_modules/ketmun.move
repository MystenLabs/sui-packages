module 0x3b2af0660b4b44dd4c4b9f1670b0b08fdf2132fd36410772cde91a15186b0098::ketmun {
    struct KETMUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KETMUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KETMUN>(arg0, 6, b"KETMUN", b"KETMUN SUI", x"5355492053757065726865726f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/page_memes_02_508a867ae1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KETMUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KETMUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

