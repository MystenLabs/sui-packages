module 0x6e26c8747d7c9bea1cbb1a24ea4178dfbb9a45cf0fdc63edabd55d0741bd41a0::fuzzy {
    struct FUZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUZZY>(arg0, 6, b"FUZZY", b"Fuzzy Bear", x"49742061696e27742061626f757420686f77206861726420796f75206869742e0a497427732061626f757420686f77206861726420796f752063616e20676574206869740a616e64206b656570206d6f76696e6720666f72776172642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033900_d218f4c5b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

