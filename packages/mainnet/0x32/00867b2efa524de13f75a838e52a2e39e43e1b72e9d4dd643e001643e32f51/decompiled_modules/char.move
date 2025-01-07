module 0x3200867b2efa524de13f75a838e52a2e39e43e1b72e9d4dd643e001643e32f51::char {
    struct CHAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAR>(arg0, 6, b"CHAR", b"CHAR Token", b"They never ask him why he fights", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/why_char_aznable_is_popular_413e4a7138.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

