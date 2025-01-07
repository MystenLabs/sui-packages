module 0x7f118ab3231829899a39107c53a648963ac4e89959431497ac9d0c79953074bf::suipei {
    struct SUIPEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEI>(arg0, 6, b"SUIPEI", b"PEIPEI ON SUI", x"504549504549204f4e20535549200a0a4d41444520464f522054484520434f4d4d554e4954590a0a4f4e434520574520424f4e44205445414d2057494c4c204255524e20544f4b454e5320414e442048414e44204f56455220544f20434f4d4d554e495459", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/peipei_sui_41ae763d26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

